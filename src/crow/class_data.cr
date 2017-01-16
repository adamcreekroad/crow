module Crow
  class ClassData
    property name : String
    property source : Crystal::ASTNode
    property name_space : String | Nil
    property classes : Array(ClassData)
    property modules : Array(ModuleData)

    def initialize(@name, @source, @name_space)
      @classes = [] of ClassData
      @modules = [] of ModuleData
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
