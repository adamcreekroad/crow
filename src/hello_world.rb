class Array < `Array`
  def concat(other)
    [self, other].flatten
  end
end

class Bar
  def foo
  end
end

module Services
  class Employee
    def initialize(name)
      @name = name
    end
  end

  module Helpers
    module Admin
      class Foo
      end
    end

    class Greeter < Employee
      def initialize(people, name)
        @people = people
        @name = name
        @count = 0
        @foo = ["foo1", "foo2"]
        @bar = ["bar1", "bar2"]
        @foo.concat(@bar)
      end

      def greet
        if @count >= 0 && @people
          @count += 1
          p "Hello World!"
        end
      end

      def greet_many_people(people_override = nil, &block)
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
