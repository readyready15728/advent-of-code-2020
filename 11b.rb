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

def seats_in_sight(i, j)
  seats = []
  beam_slopes = [
    [-1, 0], # N
    [-1, 1], # NE
    [0, 1], # E
    [1, 1], # SE
    [1, 0], # S
    [1, -1], # SW
    [0, -1], # W
    [-1, -1], # NW
  ]

  beam_slopes.each do |y, x|
    j_copy, i_copy = j, i

    while true
      j_copy += y
      i_copy += x
      break unless 0 <= j_copy and j_copy < $rows and 0 <= i_copy and i_copy < $columns

      if [:empty, :occupied].include? $grid[j_copy][i_copy]
        seats.push $grid[j_copy][i_copy]
        break
      end
    end
  end
  
  seats
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
      neighbors = seats_in_sight(i, j)

      if $grid[j][i] == :empty and neighbors.none? :occupied
        new_grid[j][i] = :occupied
      elsif $grid[j][i] == :occupied and neighbors.count(:occupied) >= 5
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
