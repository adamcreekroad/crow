class Hello
  def initialize(@people : Int32)
    @count = 0
  end

  def greet(&block)
    if @count >= 0 && @people
      @count += 1
      p "Hello World!"
      yield @count if block
    end
  end

  def greet_many_people(people_override : Int32 = nil)
    max_people = people_override || @people
    max_people -= 1
    while @count < max_people
      greet
    end
  end
end

def greet
  p "foo"
end

world = Hello.new(10)

greet do
  p "We did it reddit!"
end

class App < React::Component::Base
  param foo : String
  param bar : Int

  render do
    div do
      h1 { "Hello World!" }
    end
  end
end

# world.greet_many_people(20)
