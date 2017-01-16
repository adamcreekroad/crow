module Crow
  module Symbol
    private def transpile(node : Crystal::SymbolLiteral)
      "'#{node.value.to_s}'"
    end
  end
end
