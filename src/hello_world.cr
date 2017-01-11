class Bar
  def foo
  end
end

module Services
  class Employee
    def initialize(@name : String)
    end
  end

  module Helpers
    module Admin
      class Foo
      end
    end

    class Greeter < Employee
      def initialize(@people : Int32, @name : String)
        @count = 0
        @foo = {bar: "bar"}
      end

      def greet
        if @count >= 0 && @people
          @count += 1
          p "Hello World!"
        end
      end

      def greet_many_people(people_override : Int32 = nil, &block)
        max_people = people_override || @people
        while @count < max_people
          greet
        end
        yield(@count, @name) if block
        @count = 0
      end
    end

    class Server < Employee
      def serve
      end
    end
  end

  module Workers
    class Cashier < Employee
      def cash_out
      end
    end
  end
end
