require 'set'

ratings = Set.new

File.readlines('10.txt').each do |line|
  ratings.add line.to_i
end

ratings.add ratings.max + 3
ratings_differences = Hash.new 0
current_joltage = 0

until ratings.empty?
  # Pop minimum
  rating = ratings.min
  ratings.delete rating

  # Count difference and raise current_joltage
  ratings_differences[rating - current_joltage] += 1
  current_joltage += rating - current_joltage
end

puts ratings_differences[1] * ratings_differences[3]
