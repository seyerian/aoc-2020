class Aoc2020::TwentyThreeFirst < Aoc2020::Solution
  def parse_input(file)
    File.read_lines(file)[0].chars.map(&.to_i32)
  end

  def cup_game!(cups, last_move)
    current_cup = cups[0]
    move = 0
    lowest = cups.min
    highest = cups.max
    loop do
      move += 1
      #debug move
      #debug "-- move #{move} --"
      #debug "cups: " + cups.map { |c|
      #  c == current_cup ? "(#{c})" : c
      #}.join(' ')
      picked_up = [] of Int32
      until picked_up.size == 3
        current_i = index_of_cup(current_cup, cups)
        picked_up << cups.delete_at( index(current_i + 1, cups) )
      end
      #debug "pick up: " + picked_up.join(", ")
      destination_i = -1
      destination_cup = current_cup
      until destination_i >= 0
        destination_cup -= 1
        if destination_cup < lowest
          destination_cup = highest
        end
        destination_i = index_of_cup(destination_cup, cups)
      end
      #debug "destination: #{destination_cup}"
      picked_up = picked_up.reverse
      until picked_up.empty?
        cups.insert(destination_i + 1, picked_up.shift)
      end
      current_i = index_of_cup(current_cup, cups)
      current_cup = cups[ index(current_i + 1, cups) ]
      break if move == last_move
      #debug
    end
  end

  def index_of_cup(cup, cups)
    i = cups.index(cup)
    return -1 if i.nil?
    i
  end

  def index(i, cups)
    until i < cups.size
      i -= cups.size
    end
    until i >= 0
      i += cups.size
    end
    i
  end

  def part1(cups)
    cup_game!(cups, 100)

    one_index = index_of_cup(1, cups)
    i = index(one_index + 1, cups)
    s = ""
    until i == one_index
      s += cups[i].to_s
      i = index(i + 1, cups)
    end
    s
  end

  def part2(cups)
    until cups.size == 1_000_000
      cups.push(cups.size + 1)
    end
    cup_game!(cups, 10_000)
    i = index_of_cup(1, cups)
    c1 = cups[ index(i+1, cups) ]
    c2 = cups[ index(i+2, cups) ]
    {c1, c2, c1 * c2}
  end
end
