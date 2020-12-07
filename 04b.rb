passports = File.read('04.txt').split /\n\n/

passports = passports.map do |passport|
  fields = passport.split(/\n/).join(' ').split ' '
  passport_hash = fields.map { |field| field.split ':' }.to_h
end

valid_count = 0

def all_required_fields?(passport)
  required_fields = ['byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid']
  required_count = 0

  required_fields.each do |field|
    required_count += 1 if passport.include? field
  end

  required_count == required_fields.length
end

def valid_birth_year?(passport)
  birth_year = passport['byr'].to_i
  1920 <= birth_year and birth_year <= 2002
end

def valid_issue_year?(passport)
  issue_year = passport['iyr'].to_i
  2010 <= issue_year and issue_year <= 2020
end

def valid_expiration_year?(passport)
  expiration_year = passport['eyr'].to_i
  2020 <= expiration_year and expiration_year <= 2030
end

def valid_height?(passport)
  match = /(?<number>\d+)(?<units>in|cm)/.match(passport['hgt'])
  return false unless match
  number = match.named_captures['number'].to_i
  units = match.named_captures['units']

  if units == 'in'
    59 <= number and number <= 76
  else
    150 <= number and number <= 193
  end
end

def valid_hair_color?(passport)
  /\A#[0-9a-f]{6}\z/.match passport['hcl']
end

def valid_eye_color?(passport)
  begin
    %q{amb blu brn gry grn hzl oth}.include? passport['ecl']
  rescue
    false
  end
end

def valid_passport_id?(passport)
  /\A[0-9]{9}\z/.match passport['pid']
end

def valid_passport?(passport)
  test_outcomes = [
    all_required_fields?(passport),
    valid_birth_year?(passport),
    valid_issue_year?(passport),
    valid_expiration_year?(passport),
    valid_height?(passport),
    valid_hair_color?(passport),
    valid_eye_color?(passport),
    valid_passport_id?(passport)
  ]

  test_outcomes.all?
end
  
passports.each do |passport|
  valid_count += 1 if valid_passport? passport
end

puts valid_count
