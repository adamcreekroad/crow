# %x(
# Array.prototype.reject = function(condition) {
#   let rejectedItems = [];

#   for (let item of this) {
#     let reject = condition(item);

#     if (reject) {
#       rejectedItems.push(item);
#     }
#   }

#   for (let item of rejectedItems) {
#     this.splice(this.indexOf(item), 1);
#   }

#   return this;
# }

# Array.prototype.each = function(block) {
#   for (let item of this) {
#     block(item);
#   }
#   return this;
# }

# Array.prototype.eachWithIndex = function(block) {
#   for (let item of this) {
#     index = this.indexOf(item);
#     block(item, index);
#   }
#   return this;
# }
# )

class Foo
  class Bar
  end

  def hello
    puts "hello"
  end
end

module Services
  class Employee
    def initialize(@name : String)
      p "name is #{@name}"
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
        @foo = ["foo1", "foo2"]
        @bar = ["bar1", :bar2]
        @foo.each_with_index { |n, i| p "We are on #{n}, it is the #{i + 1} item in the array" }
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
        yield @count, @name
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

foo = Services::Helpers::Greeter.new(8, "AG")
foo.greet_many_people(4) do |count, name|
  p "we greeted #{count} people, #{name}!"
end

one = Foo.new
one.hello

two = Foo::Bar.new
two.hello
