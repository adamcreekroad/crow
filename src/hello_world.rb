class App < React::Component::Base
  param :foo, type: String
  param :bar, type: Integer

  render do
    div do
      h1 { "Hello World!" }
    end
  end
end
