require 'set'

codes = File.readlines('05.txt')
seat_ids = []

codes.each do |code|
  row_code = code[0..6]
  column_code = code[7..9]
  row = 0
  column = 0

  row_code.each_char.each_with_index do |c, i|
    if c == 'B'
      row += 2**(6 - i)
    end
  end

  column_code.each_char.each_with_index do |c, i|
    if c == 'R'
      column += 2**(2 - i)
    end
  end
  
  seat_ids.push 8 * row + column
end

all_possible_fields = Set.new(seat_ids.min..seat_ids.max)
puts (all_possible_fields - Set.new(seat_ids)).to_a[0]
