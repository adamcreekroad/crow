module Crow
  module Classes
    @@class_stack = 0

    private def transpile(node : Crystal::Path)
      case node.to_s
      when "Int32"
        "number"
      when "String"
        "string"
      when "::Nil"
        "void"
      else
        node.to_s.gsub("::", '.')
      end
    end

    private def transpile(klass : Crystal::ClassDef)
      class_name = klass.name.to_s
      if klass.superclass
        class_name += " extends #{klass.superclass.to_s}"
      end

      @@class_stack += 1
      class_body = format_body(transpile(klass.body))
      @@class_stack -= 1

      "class #{class_name} {#{class_body}}"
    end
  end
end
