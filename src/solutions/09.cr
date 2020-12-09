class Aoc2020::Nine < Aoc2020::Solution
  def parse_input(file)
    File.read_lines(file).map do |l|
      l.to_i64
    end
  end

  def part1(input)
    raise "pass preamble_length as second arg"
  end
  def part2(input)
    raise "pass preamble_length as second arg"
  end

  def part1(input, preamble_length)
    input = input.clone
    previous = input.shift(preamble_length)
    input.each do |n|
      valid = false
      previous.each_combination(2) do |(x,y)|
        if x + y == n
          valid = true
          break
        end
      end
      if valid
        previous.shift
        previous.push n
      else
        return n
      end
    end
  end

  def part2(input, preamble_length)
    input = input.clone
    target = part1(input, preamble_length)
    raise "target is nil" if target.nil?
    input.each.with_index do |n, i|
      set = [n]
      input[i+1..-1].each do |e|
        set.push e
        sum = set.sum
        if sum < target
          next
        elsif sum > target
          break
        elsif sum == target
          return set.min + set.max
        end
      end
    end
  end
end
