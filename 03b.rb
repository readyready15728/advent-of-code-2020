map = []

File.readlines('03.txt').each do |line|
  map.push line.strip.each_char.to_a
end

width, height = map[0].length, map.length
slopes = [
  [1, 1],
  [3, 1],
  [5, 1],
  [7, 1],
  [1, 2]
]
count_product = 1

slopes.each do |delta_i, delta_j|
  i, j = 0, 0
  tree_count = 0

  while j < height
    tree_count += 1 if map[j][i] == '#'
    i, j = (i + delta_i) % width, j + delta_j
  end

  count_product *= tree_count
end

puts count_product
