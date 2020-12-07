class Aoc2020::Seven < Aoc2020::Solution
  def parse_input(file)
    pat = /\A(\w+ \w+) bags contain ((?:(?:\d+ \w+ \w+ bags?|no other bags)[,\. ]*)*)\z/
    InputParsers.pattern(file, pat) do |m|
      puts m
      bags = m[2][0..-2].gsub(" bags","").gsub(" bag","").split(", ")
      if bags == ["no other"]
        bags = nil
      else
        bags = bags.map do |qty_bag|
          qbm = qty_bag.match(/\A(\d+) (\w+ \w+)\z/)
          raise "error" if qbm.nil?
          [qbm[1].to_i32, qbm[2]]
        end.to_h
      end
      {
        m[1],
        bags
      }
    end
  end

  def part1(input)
    puts input
  end

  def part2(input)
  end
end
