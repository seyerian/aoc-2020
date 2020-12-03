class Aoc2020::Three < Aoc2020::Solution
  def initialize
    @map = Array(Array(Char)).new
  end

  def parse_input(file)
    @map = Array(Array(Char)).new
    File.read_lines(file).map do |line|
      @map << line.chars
    end
  end

  def char_at(x : Int32, y : Int32)
    return nil if y >= @map.size
    row = @map[y]
    num_cells = row.size
    until x < num_cells
      x -= num_cells 
    end
    row[x]
  end

  def slope_trees(xd : Int32, yd : Int32)
    tree_count = Int64.new(0)
    x = 0
    y = 0
    loop do
      case char_at(x, y)
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

  def part1(input)
    slope_trees(3, 1)
  end

  def part2(input)
    slope_trees(1, 1) *
    slope_trees(3, 1) *
    slope_trees(5, 1) *
    slope_trees(7, 1) *
    slope_trees(1, 2)
  end
end
