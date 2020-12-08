require 'set'

bag_descriptions = {}

File.readlines('07.txt').each do |line|
  bag_type = line.match('\A(.*?) bags')[1]
  contents = []

  unless line.match('contain no other bags')
    line.scan(/(\d+) (.*?) bags?/).each do |count, color|
      contents.push [color, count.to_i]
    end
  end

  bag_descriptions[bag_type] = contents.to_h
end

def total_bag_count(bag_descriptions, bag_type)
  # Count this bag
  count = 1

  bag_descriptions[bag_type].each do |inner_bag, bag_count|
    count += bag_count * total_bag_count(bag_descriptions, inner_bag)
  end

  count
end

# Subtract one as the shiny gold bag itself is not counted
puts total_bag_count(bag_descriptions, 'shiny gold') - 1
