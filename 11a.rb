$grid = File.readlines('11.txt').map do |line|
  line.strip.each_char.map do |c|
    case c
    when '.' then :floor
    when 'L' then :empty
    when '#' then :occupied
    end
  end
end

$rows = $grid.length
$columns = $grid[0].length

def get_neighbors(i, j)
  neighbors = []

  neighbors.push $grid[j - 1][i] unless j == 0 # N
  neighbors.push $grid[j - 1][i + 1] unless j == 0 or i == $columns - 1 # NE
  neighbors.push $grid[j][i + 1] unless i == $columns - 1 # E
  neighbors.push $grid[j + 1][i + 1] unless j == $rows - 1 or i == $columns - 1 # SE
  neighbors.push $grid[j + 1][i] unless j == $rows - 1 # S
  neighbors.push $grid[j + 1][i - 1] unless j == $rows - 1 or i == 0 # SW
  neighbors.push $grid[j][i - 1] unless i == 0 # W
  neighbors.push $grid[j - 1][i - 1] unless j == 0 or i == 0  # NW

  neighbors
end

def count_occupied
  $grid.map { |row| row.count :occupied }.sum
end

def render_grid
  $grid.map do |row|
    row.map do |cell|
      case cell
      when :floor then '.'
      when :empty then 'L'
      when :occupied then '#'
      end
    end.join
  end.join "\n"
end

current_occupied = 0
last_occupied = nil

until current_occupied == last_occupied
  last_occupied = current_occupied
  new_grid = []

  $rows.times do
    new_grid.push [nil] * $columns
  end

  (0...$rows).each do |j|
    (0...$columns).each do |i|
      neighbors = get_neighbors(i, j)

      if $grid[j][i] == :empty and neighbors.none? :occupied
        new_grid[j][i] = :occupied
      elsif $grid[j][i] == :occupied and neighbors.count(:occupied) >= 4
        new_grid[j][i] = :empty
      else
        new_grid[j][i] = $grid[j][i]
      end
    end
  end
  
  $grid = new_grid
  current_occupied = count_occupied
end

puts count_occupied
