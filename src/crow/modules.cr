module Crow
  module Modules
    private def transpile(node : Crystal::ModuleDef)
      if @@module_stack.size > 0
        module_name = "#{@@module_stack.map(&.name).join('.')}.#{transpile(node.name)}"
        new_module = ModuleData.new(transpile(node.name), node, @@module_stack.map(&.name).join('.'))
        @@module_stack.last.modules << new_module
      elsif (new_module = @@modules.find { |m| m.name == transpile(node.name) })
        module_name = nil
      else
        module_name = transpile(node.name)
        new_module = ModuleData.new(module_name, node, nil)
        @@modules << new_module
      end

      @@module_stack << new_module

      transpiled_body =
        case node.body
        when Crystal::ModuleDef
          transpile(node.body)
        else
          transpile_module(node.body)
        end

      @@module_stack.pop

      if @@module_stack.size > 0
        module_name = "#{module_name} = {};"
      elsif module_name
        module_name = "const #{module_name} = {};"
      end
      p @@modules.map { |m| m.to_s.as(String) }
      <<-JS
      #{module_name}
      #{transpiled_body}
      JS
    end

    private def transpile_module(node : Crystal::Assign)
      "#{transpile(node.target)}: #{transpile(node.value)},"
    end

    private def transpile_module(node : Crystal::ModuleDef)
      transpile(node.body)
    end
    private def transpile_module(klass : Crystal::ClassDef)
      class_name = "#{@@module_stack.map(&.name).join('.')}.#{klass.name.to_s}"
      if klass.superclass
        super_class = " extends #{find_superclass(klass.superclass)}"
      end

      new_class = ClassData.new(name: klass.name.to_s, source: klass, name_space: @@module_stack.map(&.name).join('.'))
      @@class_stack << new_class
      @@module_stack.last.classes << new_class
      class_body = format_body(transpile(klass.body))
      @@class_stack.pop

      "#{class_name} = class#{super_class} {#{class_body}}"
    end

    private def find_superclass(node : Crystal::ASTNode | Nil)
      name = transpile(node)

      if (super_class = @@modules.find { |m| m.find_child_class(name) })
        name = "#{super_class.name}.#{name}"
      end

      name
    end

    private def transpile_module(node : Crystal::Def)
      receiver = node.receiver
      if receiver.is_a?(Crystal::Var) && receiver.name == "self"
        "#{transpile(node.name)}() {#{format_body(node.body)}},"
      else
        raise "Module method definitions cannot be transpiled"
      end
    end
    private def transpile_module(node : Crystal::ASTNode)
      transpile(node)
    end

    private def transpile_module(node : Crystal::Expressions)
      exps = [] of String
      node.expressions.each do |exp|
        case exp
        when Crystal::ClassDef
          exps << "#{transpile_module(exp)}"
        else
          exps << transpile(exp)
        end
      end
      exps.join("\n")
    end
  end
end
