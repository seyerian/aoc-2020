class Aoc2020::Six < Aoc2020::Solution
  def parse_input(file)
    InputParsers.groups(file)
  end

  def part1(groups)
    groups.map { |group|
      group.join(" ").gsub(" ", "").chars.uniq
    }.reduce(0) { |sum, chars|
      sum + chars.size
    }
  end

  def part2(groups)
    groups.map { |group|
      ('a'..'z').select do |char|
        group.all? do |person|
          person.includes?(char)
        end
      end
    }.reduce(0) { |sum, chars|
      sum + chars.size
    }
  end
end
