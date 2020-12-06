class Aoc2020::Two < Aoc2020::Solution
  def parse_input(file)
    InputParsers.patterns(file, /\A(\d*)-(\d*) (\w): (\w*)\z/) do |m|
      {
        m[1].to_i32,
        m[2].to_i32,
        m[3],
        m[4]
      }
    end
  end

  def part1(input)
    input.count do |i| 
      next false if i.nil?
      (i[0]..i[1]).includes? i[3].count(i[2])
    end
  end

  def part2(input)
    input.count do |line| 
      next false if line.nil?
      x = line[0] - 1
      y = line[1] - 1
      pw = line[3]
      l = line[2]
      a = pw[x].to_s
      b = pw[y].to_s
      match1 = a == l
      match2 = b == l
      match1 ^ match2
    end
  end
end
