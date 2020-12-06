valid_count = 0

File.readlines('02.txt').each do |line|
  captures = /(?<position_0>\d+)-(?<position_1>\d+) (?<character>\w): (?<candidate>\w+)/.match(line).named_captures
  position_0 = captures['position_0'].to_i - 1
  position_1 = captures['position_1'].to_i - 1
  character = captures['character']
  candidate = captures['candidate']

  valid_count += 1 if (candidate[position_0] == character) ^ (candidate[position_1] == character)
end

puts valid_count
