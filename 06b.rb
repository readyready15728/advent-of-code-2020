require 'set'

groups = File.read('06.txt').split /\n\n/

puts (groups.map do |group|
  responses = group.split(/\n/).map { |response| Set.new(response.each_char) }
  responses.inject { |product, current| product.intersection(current) }.length
end).sum
