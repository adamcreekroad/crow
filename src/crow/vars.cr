require "./ast/*"

module Crow
  module Vars
    private def transpile(node : Crystal::Assign)
      assign(node.target, transpile(node.value))
    end

    private def transpile(node : Crystal::OpAssign)
      op_assign(node.target, node.op, node.value)
    end

    private def transpile(node : AST::ConstVar)
      "const " + camelize(transpile(node.to_s))
    end

    private def transpile(node : AST::LetVar)
      "let " + camelize(transpile(node.to_s))
    end

    private def transpile(node : Crystal::Var)
      camelize(transpile(node.to_s))
    end

    private def transpile(node : Crystal::InstanceVar)
      "#{transpile Crystal::Self.new}." + camelize(transpile(node.to_s.sub(/^@/, "")))
    end

    private def assign(target, value)
      "#{transpile target} = #{transpile value};"
    end

    private def assign(target, value : Crystal::ProcLiteral)
      _def = value.def.clone
      _def.name = transpile(target)
      "#{transpile _def};"
    end

    private def op_assign(target, op : String, value)
      "#{transpile target} #{op}= #{transpile value};"
    end
  end
end
