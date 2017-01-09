class App < React::Component::Base
  def div(props = {}, &block)
    React.createElement("div", props, block)
  end

  def render
    div(className: "bar") { "Hello World" }
  end
end
