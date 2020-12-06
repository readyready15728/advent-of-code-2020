require 'set'

groups = File.read('06.txt').split /\n\n/

puts (groups.map do |group|
  Set.new(group.split(/\n/).join.each_char).length
end).sum
