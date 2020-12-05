class Aoc2020::Five < Aoc2020::Solution
  def parse_input(file)
    File.read_lines(file)
  end

  def part1(input)
    input.map { |i| seat_id(i) }.sort.reverse.first
  end

  def part2(input)
    seat_ids = input.map { |i| seat_id(i) }.sort
    lowest = seat_ids.first
    highest = seat_ids.reverse.first
    lowest.to highest do |i|
      if !seat_ids.includes?(i) && seat_ids.includes?(i+1) && seat_ids.includes?(i-1)
        return i
      end
    end
  end

  def seat_id(seat_bsp)
    row_bsp = seat_bsp[0..6].gsub("F",0).gsub("B",1)
    col_bsp = seat_bsp[7..9].gsub("L",0).gsub("R",1)
    row = row_bsp.to_i(2)
    col = col_bsp.to_i(2)
    row * 8 + col
  end
end
