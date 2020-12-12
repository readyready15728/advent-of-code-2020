instructions = File.readlines('12.txt').map do |line|
  code, value = line.match(/([NSEWLRF])(\d+)/).captures
  [code, value.to_i]
end

$cardinal_directions = %w/N E S W/

def turn(current_direction, degrees, clockwise)
  turns = degrees / 90
  current_index = $cardinal_directions.index current_direction
  # This pro-gamer move will allow me to add or subtract indices and not worry about hitting the edge
  cardinal_copies = $cardinal_directions * 3
  current_index += 4
  turns = -turns unless clockwise
  
  cardinal_copies[current_index + turns]
end

def turn_right(current_direction, degrees)
  turn current_direction, degrees, true
end

def turn_left(current_direction, degrees)
  turn current_direction, degrees, false
end

direction = 'E'
x = 0
y = 0

instructions.each do |code, value|
  code = direction if code == 'F'

  case code
  when 'N'
    y += value
  when 'S'
    y -= value
  when 'W'
    x -= value
  when 'E'
    x += value
  when 'L'
    direction = turn_left(direction, value)
  when 'R'
    direction = turn_right(direction, value)
  end
end

puts x.abs + y.abs
