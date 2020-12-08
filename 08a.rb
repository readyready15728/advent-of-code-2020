require 'set'

instructions = []

File.readlines('08.txt').each do |line|
  code, argument = line.split(' ')
  instructions.push [code, argument.to_i]
end

acc = 0
i = 0
visited = Set.new

until visited.include? i
  code, argument = instructions[i]
  visited.add i

  case code
  when 'nop'
    # Do nothing
    i += 1
  when 'acc'
    acc += argument
    i += 1
  when 'jmp'
    i += argument
  end
end

puts acc
