class Aoc2020::TwentyFive < Aoc2020::Solution
  def parse_input(file)
    File.read_lines(file).map(&.to_i32)
  end

  def determine_loop_size(subj_num, value)
    i = 0
    v = 1
    loop do
      i += 1
      v = v * subj_num
      v = v % 20201227
      if v == value
        return i
      end
    end
  end

  def transform(subj_num, loop_size)
    i = 0
    v = 1_i64
    loop do
      i += 1
      v = v * subj_num
      v = v % 20201227
      if i == loop_size
        break
      end
    end
    v
  end

  def part1(input)
    card_pub_key = input[0]
    door_pub_key = input[1]
    card_loop_size = determine_loop_size(7, card_pub_key)
    door_loop_size = determine_loop_size(7, door_pub_key)
    {
      transform(card_pub_key, door_loop_size),
      transform(door_pub_key, card_loop_size)
    }
  end

  def part2(input)
  end
end
