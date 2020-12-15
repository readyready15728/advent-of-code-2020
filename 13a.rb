lines = File.readlines('13.txt')
earliest_departure = lines[0].to_i
bus_ids = lines[1].split(',').select { |s| s != 'x' }.map &:to_i
arrivals = Hash.new 0

bus_ids.each do |id|
  while arrivals[id] < earliest_departure
    arrivals[id] += id
  end
end

earliest_pair = arrivals.select { |_, v| v == arrivals.values.min }
earliest_id = earliest_pair.keys[0]
earliest_arrival = earliest_pair.values[0]

# earliest_arrival = 0
# earliest_id = nil

# while earliest_arrival < earliest_departure
#   bus_ids.each do |id|
#     arrivals[id] += id
#   end
# 
#   arrivals.each do |k, v|
#     # If there are more than one values that exceed earliest_parture, pick the smallest
#     if v > earliest_departure and v < earliest_arrival
#       earliest_id = k
#       earliest_arrival = v
#     # Execute this clause if v is greater than earliest_departure period and the former hasn't been invoked
#     elsif v > earliest_departure
#       earliest_id = k
#       earliest_arrival = v
#     end
#   end
# end

puts (earliest_arrival - earliest_departure) * earliest_id
