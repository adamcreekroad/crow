module Crow
  class ModuleData
    property name : String
    property source : Crystal::ASTNode
    property name_space : String | Nil
    property classes : Array(ClassData)
    property modules : Array(ModuleData)

    def initialize(@name, @source, @name_space)
      @classes = [] of ClassData
      @modules = [] of ModuleData
    end

    def find_child_class(name : Array(String))
      @modules.find { |m| m.name == name } # || m.find_child(name) }
    end

    def find_child_class(name : String)
      @classes.find { |c| c.name == name } || @modules.find { |m| m.find_child_class(name) }
    end

    def find_child_module(name : String)
      @modules.find { |m| m.name == name } || @modules.find { |m| m.find_child_module(name) }
    end

    def to_s
      "Name: #{name}, Modules: #{@modules.map { |m| m.to_s.as(String) }}"
    end

    def to_n : String
      <<-JS
      {
        "name": #{name},
        "classes": #{classes.map { |c| c.to_n.as(String) }},
        "modules": #{modules.map { |m| m.to_n.as(String) }}
      }
      JS
    end
  end
end
