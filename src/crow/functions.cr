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

      # p transpile(method.body)
      # p method.body.class

      method_body = if original_name == "initialize"
                      format_body(transpile(method.body))
                    else
                      format_body(transpile_with_return(method.body))
                    end

      if @@class_stack == 0
        name = "function #{name}"
      end

      <<-JS
      #{camelize(name)}(#{args.join(", ")}) {#{method_body}}
      JS
    end

    private def transpile(node : Crystal::Block)
      body = format_body(transpile(node.body))
      "(#{transpile(node.args).join(", ")}) => {#{body}}"
    end

    private def transpile(call : Crystal::Call)
      method = call.name

      if @@macros[call.name]?
        return transpile_macro(call, @@macros[call.name])
      end

      case call.name
      when "+", "-", "*", "/", ">", ">=", "<", "<=", "==", "!="
        "#{transpile call.obj} #{call.name} #{transpile call.args[0]}"
      else
        args = transpile call.args
        block = transpile call.block
        if block.is_a?(String)
          args = args.concat([block])
        end
        p "args class: #{args.class}"
        p "block class #{block.class}"

        # if call.block
        #
        #   args << block
        # end

        method = "console.log" if method == "p"
        method = "throw new Error" if method == "raise"

        if call.obj
          if method == "new"
            method = "#{method} #{call.obj}"
          else
            method = "#{call.obj}.#{method}"
          end
        end

        if @@class_stack > 0
          klass = "#{transpile Crystal::Self.new}."
        end

        "#{klass}#{camelize(method)}(#{args.join(", ")});"
      end
    end

    private def transpile_with_return(node : Crystal::ASTNode)
      node = transpile(node)
      "#{transpile(node)}\nreturn;"
    end

    private def transpile_with_return(node : Crystal::NumberLiteral)
      "#{transpile(node)}\nreturn;"
    end

    private def transpile_with_return(node : Crystal::Nop)
      ""
    end
  end
end
