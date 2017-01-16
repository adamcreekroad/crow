module Crow
  module Classes
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
      if @@class_stack.size > 0
        new_class = ClassData.new(class_name, klass, @@class_stack.map(&.name).join('.'))
      else
        new_class = ClassData.new(class_name, klass, nil)
      end
      @@classes << new_class
      @@class_stack << new_class
      class_body = format_body(transpile(klass.body))
      @@class_stack.pop

      "class #{class_name} {#{class_body}}"
    end
  end
end
