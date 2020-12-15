class Aoc2020::Fifteen < Aoc2020::Solution
  def parse_input(file)
    File.read(file).split(',').map(&.to_i32)
  end

  # uses growing array of all numbers spoken
  def memory_game(starting_numbers, stop)
    numbers = starting_numbers.clone
    turn = numbers.size + 1
    loop do
      last = numbers[-1]
      if numbers.count(last) == 1
        numbers << 0
      else
        prev = numbers.rindex(last, offset: turn - 3)
        unless prev.nil?
          numbers << turn - 1 - (prev + 1)
        end
      end
      if turn == stop
        return numbers[-1]
      end
      turn += 1
    end
  end

  # optimized, no array. uses hash of spoken => last turn spoken
  def memory_game2(starting_numbers, stop)
    memory = Hash(Int32, Int32).new
    starting_numbers.each.with_index do |n, i|
      memory[n] = i + 1
    end
    last_spoken = nil
    spoken = starting_numbers.last
    turn = starting_numbers.size + 1
    loop do
      if last_spoken.nil?
        spoken = 0
      else
        spoken = turn - 1 - last_spoken
      end
      last_spoken = memory[spoken]?
      memory[spoken] = turn
      if turn == stop
        return spoken
      end
      turn += 1
    end
  end

  def part1(starting_numbers)
    memory_game2(starting_numbers, 2020)
  end

  def part2(starting_numbers)
    memory_game2(starting_numbers, 30_000_000)
  end
end
