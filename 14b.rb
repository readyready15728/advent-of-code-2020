def parse_mask_line(line)
  initial_mask = line.match(/\Amask = (.+)\z/).captures[0]
  ['mask', expand_mask_instruction(initial_mask)]
end

def expand_mask_instruction(mask)
  floating_indices = mask.enum_for(:scan, /X/).map { Regexp.last_match.begin(0) }
  floating_switches = []

  # Get combinations of floating_indices from size 0 to size n, so to speak
  (0..floating_indices.length).each do |i|
    floating_switches += floating_indices.combination(i).to_a
  end

  # Initialize as many masks as arrays in floating_switches with all floating indices set to Z (for "zero")
  expanded_masks = []

  floating_switches.length.times do
    expanded_masks.push mask.gsub('X', 'Z')
  end

  # Iterate through floating switches, writing O's (for "one") where specified by each array in the proper mask
  floating_switches.each_with_index do |a, i|
    a.each do |j|
      expanded_masks[i][j] = 'O'
    end
  end

  # Lastly turn the strings to arrays
  expanded_masks.map(&:each_char).map(&:to_a)
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
    elsif m == 'Z'
      new_bit_string.push false
    elsif m == 'O'
      new_bit_string.push true
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

masks = nil

instructions.each do |instruction|
  if instruction[0] == 'mask'
    masks = instruction[1]
  else
    address, value = instruction[1]

    masks.each do |mask|
      masked_address = bit_string_to_integer(mask_bit_string(mask, integer_to_bit_string(address)))
      address_space[masked_address] = value
    end
  end
end

puts address_space.values.sum
