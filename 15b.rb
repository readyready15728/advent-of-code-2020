starting_numbers = File.readlines('15.txt')[0].split(',').map { |n| n.to_i }
number_count = (Hash.new 0).merge starting_numbers.map { |n| [n, 1] }.to_h
last_mentions = {}

starting_numbers.each_with_index do |n, i|
  last_mentions[n] = [i + 1]
end

last_number = starting_numbers[-1]
turn = starting_numbers.length

until turn == 30_000_000
  turn += 1

  # Say 0 if last_number was spoken for the first time
  if number_count[last_number] == 1
    current_number = 0
  # If the number HAS been spoken before, say how many turns apart from the
  # time it was spoken and the time it was second-to-last spoken. (The
  # specification for this one was TERRIBLE!)
  else
    current_number = last_mentions[last_number][-1] - last_mentions[last_number][-2]
  end

  number_count[current_number] += 1

  unless last_mentions.include? current_number
    last_mentions[current_number] = [turn]
  else
    last_mentions[current_number].push turn
  end

  last_number = current_number
end
  
puts current_number
