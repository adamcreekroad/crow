module Crow
  module Functions
    private def transpile(method : Crystal::Def)
      original_name = method.name

      name = original_name == "initialize" ? "constructor" : original_name
      if method.receiver && method.receiver.to_s == "self"
        name = "static #{name}"
      end

      args = method.args.map do |arg|
        val = camelize("#{arg.name}")

        # TODO: Implement type checking
        # case arg.restriction
        # when Crystal::Path
        #   val += " : #{arg.restriction.to_s}"
        # end
        val
      end

      block = transpile method.block_arg
      args = args.concat(["callback"]) if block.is_a?(String)

      # p transpile_with_return(method.body)
      # p method.body

      method_body = if original_name == "initialize"
                      format_body(transpile(method.body))
                    else
                      format_body(transpile_with_return(method.body))
                    end

      if original_name == "->"
        name = "(#{args.join(", ")}) =>"
      elsif @@class_stack == 0
        name = "function #{camelize(name)}"
      else
        name = "#{camelize(name)}(#{args.join(", ")})"
      end

      <<-JS
      #{name} {#{method_body}}
      JS
    end

    private def transpile(node : Crystal::Block)
      body = format_body(transpile(node.body))
      "(#{transpile(node.args).join(", ")}) => {#{body}}"
    end

    private def transpile(node : Crystal::Yield)
      exps = transpile node.exps
      "callback(#{exps.join(", ")});"
    end

    private def transpile(call : Crystal::Call)
      method = call.name

      if @@macros[call.name]?
        return transpile_macro(call, @@macros[call.name])
      end

      case call.name
      when "+", "-", "*", "/", ">", ">=", "<", "<=", "==", "!=", "==="
        "#{transpile call.obj} #{call.name} #{transpile call.args[0]}"
      when "`"
        "#{transpile(call.args[0]).gsub('\'', "")}"
      else
        args = transpile call.args
        block = transpile call.block
        args = args.concat([block]) if block.is_a?(String)

        method = "console.log" if method == "p"
        method = "throw new Error" if method == "raise"

        if call.obj
          if method == "new"
            method = "#{method} #{transpile call.obj}"
          elsif method == "call"
            method = "#{transpile call.obj}"
          else
            method = "#{transpile call.obj}.#{method}"
          end
        end

        "#{camelize(method)}(#{args.join(", ")});"
      end
    end

    private def transpile_with_return(node : Crystal::Expressions)
      transpiled_exps = node.expressions.map { |e| transpile(e) }
      transpiled_exps << "return #{transpiled_exps.pop};"
      transpiled_exps.join('\n')
    end

    private def transpile_with_return(node : Crystal::ASTNode)
      "return #{transpile(node)};"
    end

    private def transpile_with_return(node : Crystal::NumberLiteral)
      transpile(node)
    end

    private def transpile_with_return(node : Crystal::Nop)
      ""
    end

    private def transpile_proc(node : Crystal::ASTNode)
      node.to_s
    end
  end
end
