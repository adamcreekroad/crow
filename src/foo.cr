require "./crow.cr"

file = File.read("./hello_world.cr")
res = Crow.convert(file)

File.open("./hello_world.js", "w+") do |f|
  f << res
end
