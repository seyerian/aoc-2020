class Aoc2020::TwentyFour < Aoc2020::Solution
  def parse_input(file)
    File.read_lines(file).map do |line|
      dirs = [] of String
      line.scan(/(se|sw|nw|ne|e|w)/) do |match|
        dirs << match[1]
      end
      dirs
    end
  end

  def draw(floor : Space)
    sorter = ->(coords : Coords, color : Bool) { [-1 * coords[:r], -1 * coords[:q]] }
    last_r = -1000
    floor.each(sorter) do |coords, color|
      if last_r != coords[:r] 
        unless last_r == -1000
          puts
        end
        print " " * coords[:r].abs
      end
      last_r = coords[:r]
      print color == BLACK ? "<B" : "<W"
    end
    puts
  end

  BLACK = true
  WHITE = false

  def construct_floor(tiles)
    space = Space(Coords, Bool).new
    tiles.each do |dirs|
      hash = dirs.reduce({"r" => 0, "q" => 0}) do |h, dir|
        case dir
        when "se"
          h["r"] += 1
        when "sw"
          h["r"] += 1
          h["q"] -= 1
        when "nw"
          h["r"] -= 1
        when "ne"
          h["r"] -= 1
          h["q"] += 1
        when "e"
          h["q"] += 1
        when "w"
          h["q"] -= 1
        end
        h
      end
      coords = {r: hash["r"], q: hash["q"]}
      is_black = space.get(coords)
      space.set(coords, !is_black)
    end
    space
  end

  alias Coords = {r: Int32, q: Int32}
  def part1(tiles)
    floor = construct_floor(tiles)
    floor.count_cell(true)
  end

  def part2(tiles)
    floor = construct_floor(tiles)
    until floor.time == 100
      #debug "t=#{floor.time}"
      #debug floor.count_cell(true)
      unset = [] of Coords
      floor.each do |coords, color|
        flip(floor, coords, color) do |unset_neighbor|
          unset << unset_neighbor
        end
      end
      unset.each do |coords|
        flip(floor, coords, WHITE) {}
      end
      floor.step
      #draw(floor)
    end
    floor.count_cell(true)
  end

  def flip(floor, coords, color)
    black_count = 0
    [1, -1, 0].each_permutation(2).each do |neighbor_offset|
      neighbor = {
        r: coords[:r] + neighbor_offset[0],
        q: coords[:q] + neighbor_offset[1],
      }
      neighbor_black = floor.get(neighbor)
      if neighbor_black.nil?
        yield(neighbor)
      end
      black_count += 1 if neighbor_black
    end
    floor.time_offset = 1
    case color
    when BLACK
      if black_count == 0 || black_count > 2
        floor.set(coords, WHITE)
      else
        floor.set(coords, BLACK)
      end
    else # white
      if black_count == 2
        floor.set(coords, BLACK)
      else
        floor.set(coords, WHITE)
      end
    end
    floor.time_offset = 0
  end
end
