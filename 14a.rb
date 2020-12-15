def parse_mask_line(line)
  ['mask', line.match(/\Amask = (.+)\z/).captures[0].each_char.to_a]
end

def parse_mem_line(line)
  ['mem', line.match(/\Amem\[(\d+)\] = (\d+)\z/).captures.map { |capture| capture.to_i }]
end

def integer_to_bit_string(integer)
  bit_string = [false] * 36
  i = bit_string.length - 1

  while integer > 0
    bit_string[i] = integer.odd?
    integer /= 2
    i -= 1
  end

  bit_string
end

def mask_bit_string(mask, bit_string)
  new_bit_string = []

  mask.zip(bit_string).each do |m, b|
    if m == '1'
      new_bit_string.push true
    elsif m == '0'
      new_bit_string.push false
    else
      new_bit_string.push b
    end
  end

  new_bit_string
end

def bit_string_to_integer(bit_string)
  i = 0
  sum = 0

  while i < 36
    sum += 2**i if bit_string[35 - i]
    i += 1
  end
  
  sum
end

address_space = Hash.new 0

instructions = File.readlines('14.txt').map do |line|
  line.strip!

  if line.match(/\Amask/)
    parse_mask_line(line)
  else
    parse_mem_line(line)
  end
end

mask = nil

instructions.each do |instruction|
  if instruction[0] == 'mask'
    mask = instruction[1]
  else
    address, value = instruction[1]
    masked_value = bit_string_to_integer(mask_bit_string(mask, integer_to_bit_string(value)))
    address_space[address] = masked_value
  end
end

puts address_space.values.sum
