passports = File.read('04.txt').split /\n\n/

passports = passports.map do |passport|
  fields = passport.split(/\n/).join(' ').split ' '
  fields.map { |field| field.split ':' }.to_h
end

valid_count = 0

passports.each do |passport|
  required_fields = ['byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid']
  required_count = 0

  required_fields.each do |field|
    required_count += 1 if passport.include? field
  end

  valid_count += 1 if required_count == required_fields.length
end

puts valid_count
