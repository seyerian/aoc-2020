class Aoc2020::Ten < Aoc2020::Solution
  def parse_input(file)
    File.read_lines(file).map { |l| l.to_i32 }.sort
  end

  def differences(input)
    diffs = [] of Int32
    last = 0 # charging outlet
    input.each do |i|
      diffs << i - last
      last = i
    end
    diffs << 3 # device
    diffs
  end

  def part1(input)
    diffs = differences(input)
    d1 = diffs.count(1)
    d3 = diffs.count(3)
    { d1, d3, d1*d3 }
  end

  def part2(input)
    diffs = differences(input)
    one_chains = [] of Int32
    last = 0
    diffs.each do |diff|
      if diff == 1
        if last == 1
          one_chains[-1] = one_chains[-1] + 1
        else
          # 0 instead of 1. we need to shorten the chain total by 1,
          # because the last element precedes a 3 and cannot be removed
          one_chains << 0
        end
      end
      last = diff
    end
    one_chains.reduce(1) do |product, l|
      removals = 2 ** l
      # removal chains of length >= 3 are invalid.
      # the count is the triangle number of the difference of the length
      # and 3, plus 3 itself, so count - 2. see below for example.
      invalid = 
        if l >= 3
          n = l - 2
          n * (n+1) / 2 # triangle number
        else
          0
        end
      product * (removals - invalid)
    end.to_i64
  end

  # invalid removals for one-chain of length 6
  # the count (10) is the triangle number of 6 - 2 = 4
  # 1 1 1 1 1 1
  # x x x x x x
  # 1 x x x x x
  # x x x x x 1
  # 1 1 x x x x
  # 1 x x x x 1
  # x x x x 1 1
  # 1 1 1 x x x
  # x 1 1 1 x x
  # x x 1 1 1 x
  # x x x 1 1 1
end
