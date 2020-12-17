class Aoc2020::Seventeen < Aoc2020::Solution
  ACTIVE = '#'
  INACTIVE = '.'

  def parse_input(file)
    maps = InputParsers.groups(file)
    map_s = maps.first.join("\n")
    map = Map.new([INACTIVE,ACTIVE])
    map.import(map_s)
    map.out_of_bounds = true
    map
  end

  def part1(map)
    loop do
      if map.time == 6
        return map.count(ACTIVE)
      end
      #map.draw(z: 0)
      map.each_char do |x, y, z, char|
        n_chars = map.cube_neighbors(x, y, z).map do |n|
          n[:char]
        end
        n_active = n_chars.count(ACTIVE)
        if char == ACTIVE
          if n_active == 2 || n_active == 3
            map.set(x, y, z, ACTIVE, 1)
          else
            map.set(x, y, z, INACTIVE, 1)
          end
        else
          if n_active == 3
            map.set(x, y, z, ACTIVE, 1)
          else
            map.set(x, y, z, INACTIVE, 1)
          end
        end
      end # each_char
      map.step
    end
  end

  def part2(input)
  end
end
