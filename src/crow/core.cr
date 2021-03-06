module Crow
  module Core
    private def transpile(node : String)
      node
    end

    private def transpile(node : Crystal::ASTNode)
      log_fallback_usage(node)
      node.to_s
    end

    private def transpile(nodes : Array(Crystal::ASTNode) | Nil)
      case nodes
      when Nil
        [] of String
      else
        nodes.map do |node|
          transpile node
        end
      end
    end

    private def transpile(node : Crystal::Self)
      "this"
    end

    private def transpile(node : Crystal::Nop)
      ""
    end

    private def transpile(node : Crystal::Return)
      if node.exp
        "return #{transpile node.exp};"
      else
        "return;"
      end
    end

    private def transpile(node : Crystal::ProcLiteral)
      _def = node.def
      _def.name = ""
      transpile _def
    end

    private def camelize(node : String)
      string = node.sub(/^(?:(?=\b|[A-Z_])|\w)/) { |s| s.downcase }
      string.gsub(/(?:_|(\/))([a-z\d]*)/) { |s, m| "#{m[1]?}#{m[2].capitalize}" }
            .gsub('/', "::")
    end
  end
end
