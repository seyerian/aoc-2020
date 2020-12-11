class Aoc2020::Eleven < Aoc2020::Solution
  def parse_input(file)
    maps = InputParsers.groups(file)
    map_s = maps.first.join("\n")
    map = Map.new(['L','#','.'])
    map.import(map_s)
    map
  end

  def part1(map)
    loop do
      #map.draw
      map.each_char do |x, y, char|
        n_chars = map.neighbors(x, y, true).map do |n|
          n[:char]
        end
        if char == 'L' && !n_chars.includes?('#')
          map.set(x, y, '#', 1)
        elsif char == '#' && n_chars.count('#') >= 4
          map.set(x, y, 'L', 1)
        else
          map.set(x, y, char, 1)
        end
      end # each_char
      map.step
      if map.state == map.state(-1)
        return map.count('#')
      end
    end
  end

  def part2(map)
    loop do
      #map.draw
      map.each_char do |x, y, char|
        n_chars = map.lines_of_sight(x, y, ['L', '#'], true).map do |n|
          n[:char].as(Char)
        end
        if char == 'L' && !n_chars.includes?('#')
          map.set(x, y, '#', 1)
        elsif char == '#' && n_chars.count('#') >= 5
          map.set(x, y, 'L', 1)
        else
          map.set(x, y, char, 1)
        end
      end # each_char
      map.step
      if map.state == map.state(-1)
        return map.count('#')
      end
    end
  end
end
