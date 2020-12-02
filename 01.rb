expenses = []

File.readlines('01.txt').each do |line|
  expenses.push line.to_i
end

expenses.each_with_index do |x, i|
  expenses.each_with_index do |y, j|
    if i != j and x + y == 2020
      puts x * y
      exit
    end
  end
end
