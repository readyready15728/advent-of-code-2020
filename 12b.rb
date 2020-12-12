instructions = File.readlines('12.txt').map do |line|
  code, value = line.match(/([NSEWLRF])(\d+)/).captures
  [code, value.to_i]
end

def rotate(code, degrees, waypoint_x, waypoint_y)
  if (code == 'L' and degrees == 90) or (code == 'R' and degrees == 270)
    [-waypoint_y, waypoint_x]
  elsif degrees == 180
    [-waypoint_x, -waypoint_y]
  elsif (code == 'L' and degrees == 270) or (code == 'R' and degrees == 90)
    [waypoint_y, -waypoint_x]
  else
    [waypoint_x, waypoint_y]
  end
end

plane_x = 0
plane_y = 0
waypoint_x = 10
waypoint_y = 1

instructions.each do |code, value|
  case code
  when 'N'
    waypoint_y += value
  when 'S'
    waypoint_y -= value
  when 'W'
    waypoint_x -= value
  when 'E'
    waypoint_x += value
  when /L|R/
    waypoint_x, waypoint_y = rotate(code, value, waypoint_x, waypoint_y)
  when 'F'
    plane_x += waypoint_x * value
    plane_y += waypoint_y * value
  end
end

puts plane_x.abs + plane_y.abs
