class Aoc2020::Thirteen < Aoc2020::Solution
  def parse_input(file)
    file
  end
  
  def first_multiple_after(n, x)
    i = 1
    loop do
      m = n * i
      return m if m >= x
      i += 1
    end
  end

  def part1(file)
    lines = File.read_lines(file)
    timestamp = lines[0].to_i64
    buses = lines[1].split(',').reject(&.==("x")).map(&.to_i64)
    input = {timestamp, buses}
    timestamp = input[0]
    buses = input[1]
    bus = buses.map { |bus|
      {bus, first_multiple_after(bus, timestamp)}
    }.sort_by { |bus|
      bus[1]
    }.first
    bus[0] * (bus[1] - timestamp)
  end

  def part2(file)
    lines = File.read_lines(file)
    parts = lines[1].split(',')
    times = parts.map_with_index { |p, i| {p, i} }
    buses = times.select { |p| p[0] != "x" }
    overlaps = [] of {Int64, Int64}
    fbus = buses.shift
    a = buses.reduce({fbus[0].to_i64, nil}) do |prev,bus|
      t_overlap(prev[0].to_i64, bus[0].to_i64, bus[1].to_i64, prev[1])
    end
    a[0]
  end

  def t_overlap(x, y, yt, di : Nil | Int64)
    i = 0_i64
    di = x if di.nil?
    m = [] of Int64
    until m.size > 1
      dx = x + (i * di)
      if (dx + yt) % y == 0
        m << dx
      end
      i += 1
    end
    r = {m[0], m[1] - m[0]}
    return r
  end
end
