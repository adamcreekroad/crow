require "./crow.cr"

file = File.read("./app.cr")
res = Crow.convert(file)

File.open("./app.js", "w+") do |f|
  f << res
end
