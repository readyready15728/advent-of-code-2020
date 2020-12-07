require 'set'

bag_descriptions = []

File.readlines('07.txt').each do |line|
  bag_type = line.match('\A(.*?) bags')[1]
  contents = []

  unless line.match('contain no other bags')
    line.scan(/(\d+) (.*?) bags?/).each do |count, color|
      contents.push [color, count]
    end
  end

  bag_descriptions.push({"bag_type" => bag_type, "contents" => contents.to_h})
end

def scan_for_possible_containers(bag_descriptions, previous_possible_containers)
  new_containers = Set.new

  bag_descriptions.each do |bag_description|
    # Direct container of shiny gold bags
    if bag_description['contents'].include? 'shiny gold'
      # Don't need to check if already present because Set class is used
      new_containers.add bag_description['bag_type']
    end

    # Indirect containers of shiny gold bags
    unless previous_possible_containers.intersection(Set.new bag_description['contents'].keys).empty?
      # Again, no need to check if already present
      new_containers.add bag_description['bag_type']
    end
  end

  new_containers
end

previous_possible_containers = Set.new
# Initial scan
current_possible_containers = scan_for_possible_containers(bag_descriptions, previous_possible_containers)

# Keep iterating until all possible choices are exhuasted
until previous_possible_containers == current_possible_containers
  previous_possible_containers = current_possible_containers
  current_possible_containers = scan_for_possible_containers(bag_descriptions, previous_possible_containers)
end

puts current_possible_containers.length
