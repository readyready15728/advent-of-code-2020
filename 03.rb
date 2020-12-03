map = []

File.readlines('03.txt').each do |line|
  map.push line.strip.each_char.to_a
end

i, j = 0, 0
width, height = map[0].length, map.length
tree_count = 0

while j < height
  tree_count += 1 if map[j][i] == '#'
  i, j = (i + 3) % width, j + 1
end

puts tree_count
