module Crow
  module Modules
    @@module_stack = 0

    private def transpile(node : Crystal::ModuleDef)
      if @@module_stack > 0
        module_name = "#{@@modules[@@module_stack - 1]}.#{transpile(node.name)}"
        @@modules << module_name
      else
        module_name = transpile(node.name)
        @@modules << module_name
      end

      @@module_stack += 1

      transpiled_body =
        case node.body
        when Crystal::ModuleDef
          transpile(node.body)
        else
          transpile_module(node.body)
        end

      @@module_stack -= 1

      if @@module_stack > 0
        module_name = "#{module_name}"
      else
        module_name = "const #{module_name}"
      end

      <<-JS
      #{module_name} = {};
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
      class_name = "#{@@modules[@@module_stack - 1]}.#{klass.name.to_s}"

      if klass.superclass
        super_class = " extends #{find_superclass(klass.superclass)}"
      end

      @@class_stack += 1
      class_body = format_body(transpile(klass.body))
      @@class_stack -= 1

      "#{class_name} = class#{super_class} {#{class_body}}"
    end

    private def find_superclass(node : Crystal::ASTNode | Nil)
      foo = @@modules.map { |m| m if m.scan(/#{node.to_s}/).any? }.compact
      node.to_s
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
