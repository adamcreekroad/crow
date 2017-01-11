module Components
  class App < React::Component::Base
    def scroll_up
      Document.scroll_to(0)
    end

    render do
      div do
        h1 { "Hello World!" }
      end
    end
  end
end
