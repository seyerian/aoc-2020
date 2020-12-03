class Aoc2020::One < Aoc2020::Solution
  def parse_input(file)
    File.read_lines(file).map{|s|s.to_i32}
  end

  def part1(input)
    input.each_combination(2).each do |(a,b)|
      if a + b == 2020
        return a * b
      end
    end
  end

  def part2(input)
    input.each_combination(3).each do |(a,b,c)|
      if a + b + c == 2020
        return a * b * c
      end
    end
  end
end
