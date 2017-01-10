class Greeter
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
    max_people = 1
    while @count < max_people
      greet
    end
    yield(@count, @name)
  end
end

def do_some_greetings(@people, @name)
  greeter = Greeter.new(@people, @name)

  greeter.greet_many_people do |count, name|
    p "We',ve greeted #{count} people, #{name}!"
  end
end

foo = ->(x : Int32, y : Int32) { p(x + y) }

foo.call(3, 4)
