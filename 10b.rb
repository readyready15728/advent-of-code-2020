ratings = []

File.readlines('10.txt').each do |line|
  ratings.push line.to_i
end

ratings.sort!
ratings.push ratings[-1] + 3

dp = Hash.new 0
dp[0] = 1

ratings.each do |rating|
  dp[rating] = dp[rating - 1] + dp[rating - 2] + dp[rating - 3]
end

puts dp[ratings[-1]]
