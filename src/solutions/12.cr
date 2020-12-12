class Aoc2020::Twelve < Aoc2020::Solution
  def parse_input(file)
    InputParsers.pattern(file, /\A(\w)(\d+)\z/) do |m|
      {
        m[1][0],
        m[2].to_i
      }
    end
  end

  def part1(instructions)
    x = 0
    y = 0
    r = 0
    instructions.each do |i|
      next if i.nil?
      case i[0]
      when 'N' then y += i[1]
      when 'E' then x += i[1]
      when 'S' then y -= i[1]
      when 'W' then x -= i[1]
      when 'L' then r -= i[1]
      when 'R' then r += i[1]
      when 'F'
        case r
        when 0 then x += i[1]
        when 90 then y -= i[1]
        when 180 then x -= i[1]
        when 270 then y += i[1]
        end
      end
      while r >= 360
        r -= 360
      end
      while r < 0
        r += 360
      end
    end
    x.abs + y.abs
  end

  def part2(instructions)
    wx = 10
    wy = 1
    x = 0
    y = 0
    instructions.each do |i|
      next if i.nil?
      #puts "#{i[0]} #{i[1]}"
      case i[0]
      when 'N' then wy += i[1]
      when 'E' then wx += i[1]
      when 'S' then wy -= i[1]
      when 'W' then wx -= i[1]
      when 'L'
        case i[1]
        when 90
          wx, wy = (-1 * wy), wx
        when 180
          wx = -1 * wx
          wy = -1 * wy
        when 270 
          wx, wy = wy, (-1 * wx)
        end
      when 'R'
        case i[1]
        when 90
          wx, wy = wy, (-1 * wx)
        when 180
          wx = -1 * wx
          wy = -1 * wy
        when 270 
          wx, wy = (-1 * wy), wx
        end
      when 'F'
        x = x + wx * i[1]
        y = y + wy * i[1]
      end
      #puts "waypoint @ (#{wx}, #{wy})"
      #puts "ship @ (#{x}, #{y})"
      #puts "--------"
    end
    x.abs + y.abs
  end
end
