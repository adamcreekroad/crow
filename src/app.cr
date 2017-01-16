module Components
  class App < React::Component
    def name
      "Adam George"
    end

    def render
      React.create_element("div", nil, "Hello #{@props.to_what}")
    end
  end
end
