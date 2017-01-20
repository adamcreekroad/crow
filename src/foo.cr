require "./crow.cr"

file = File.read("./stdlib/array.cr")
res = Crow.convert(file)

File.open("./stdlib/array.js", "w+") do |f|
  f << res
end
