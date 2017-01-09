module Crow
  module BinaryOps
    private def transpile(node : Crystal::Or)
      left = transpile(node.left)
      right = transpile(node.right)

      "(#{left} || #{right})"
    end

    private def transpile(node : Crystal::And)
      left = transpile(node.left)
      right = transpile(node.right)

      "(#{left} && #{right})"
    end
  end
end
