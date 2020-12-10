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

def find_invalid_number(numbers)
  (25..numbers.length).each do |i|
    previous_25 = numbers[i - 25...i]
    return numbers[i] unless has_xmas_property? previous_25, numbers[i]
  end
end

invalid_number = find_invalid_number(numbers)

pointer_left = 0
pointer_right = 1
sum = numbers[pointer_left..pointer_right].sum

while sum != invalid_number
  if sum < invalid_number
    pointer_right += 1
    sum += numbers[pointer_right]
  elsif sum > invalid_number
    sum -= numbers[pointer_left]
    pointer_left += 1
  end
end

puts numbers[pointer_left...pointer_right].minmax.sum
