class Aoc2020::One < Aoc2020::Solution
  def self.input
    File.read_lines("inputs/01").map{|s|s.to_i32}
  end

  def self.part1
    input.each_combination(2).each do |(a,b)|
      if a + b == 2020
        return a * b
      end
    end
  end

  def self.part2
    input.each_combination(3).each do |(a,b,c)|
      if a + b + c == 2020
        return a * b * c
      end
    end
  end
end
