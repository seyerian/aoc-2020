class Aoc2020::Three < Aoc2020::Solution
  def parse_input(file)
    map = Array(Array(Char)).new
    File.read_lines(file).map do |line|
      map << line.chars
    end
    map
  end

  def char_at(map : Array(Array(Char)), x : Int32, y : Int32)
    return nil if y >= map.size
    row = map[y]
    num_cells = row.size
    until x < num_cells
      x -= num_cells 
    end
    row[x]
  end

  def slope_trees(map : Array(Array(Char)), xd : Int32, yd : Int32)
    tree_count = Int64.new(0)
    x = 0
    y = 0
    loop do
      case char_at(map, x, y)
      when '#'
        tree_count += 1
      when '.'
      when nil
        break
      end
      x += xd
      y += yd
    end
    tree_count
  end

  def part1(map)
    slope_trees(map, 3, 1)
  end

  def part2(map)
    slope_trees(map, 1, 1) *
    slope_trees(map, 3, 1) *
    slope_trees(map, 5, 1) *
    slope_trees(map, 7, 1) *
    slope_trees(map, 1, 2)
  end
end
