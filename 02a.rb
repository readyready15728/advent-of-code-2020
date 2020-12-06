passwords = []

File.readlines('02.txt').each do |line|
  captures = /(?<lower_bound>\d+)-(?<upper_bound>\d+) (?<character>\w): (?<candidate>\w+)/.match(line).named_captures
  captures['lower_bound'] = captures['lower_bound'].to_i
  captures['upper_bound'] = captures['upper_bound'].to_i
  passwords.push captures
end

puts (passwords.select do |password|
  instances = password['candidate'].count password['character']
  password['lower_bound'] <= instances and instances <= password['upper_bound']
end).length
