expenses = []

File.readlines('01.txt').each do |line|
  expenses.push line.to_i
end

expenses.each_with_index do |x, i|
  expenses.each_with_index do |y, j|
    expenses.each_with_index do |z, k|
      if i != j and i != k and j != k and x + y + z == 2020
        puts x * y * z
        exit
      end
    end
  end
end
