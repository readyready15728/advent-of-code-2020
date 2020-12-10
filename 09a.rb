numbers = []

File.readlines('09.txt').each do |line|
  numbers.push line.to_i
end

def has_xmas_property?(previous_25, current_value)
  previous_25.each_with_index do |x, i|
    previous_25.each_with_index do |y, j|
      return true if i != j and x + y == current_value
    end
  end

  false
end

(25..numbers.length).each do |i|
  previous_25 = numbers[i - 25...i]
  puts numbers[i] unless has_xmas_property? previous_25, numbers[i]
end
