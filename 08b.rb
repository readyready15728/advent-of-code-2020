require 'set'

instructions = []

File.readlines('08.txt').each do |line|
  code, argument = line.split(' ')
  instructions.push [code, argument.to_i]
end

swap_indices = instructions.each_with_index.select do |instruction, i|
  code = instruction[0]
  code == 'nop' or code == 'jmp'
end.map do |instruction, i|
  i
end

swap_indices.each do |j|
  acc = 0
  i = 0
  visited = Set.new
  new_instructions = Marshal.load(Marshal.dump(instructions))

  if new_instructions[j][0] == 'jmp'
    new_instructions[j][0] = 'nop'
  else
    new_instructions[j][0] = 'jmp'
  end

  until visited.include? i
    code, argument = new_instructions[i]
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
    when nil
      # Stepped out of instructions array
      puts acc
      break
    end
  end
end
