class Aoc2020::Seventeen < Aoc2020::Solution
  ACTIVE = '#'
  INACTIVE = '.'
  Z = 0_i8
  P = 1_i8
  N = -1_i8

  def parse_input(file)
    file
  end

  def part1(file)
    map_s = File.read(file)
    map = Map.new([INACTIVE,ACTIVE])
    map.import(map_s)
    map.out_of_bounds = true

    loop do
      if map.time == 6
        return map.count(ACTIVE)
      end
      #map.draw(z: 0)
      map.each_char do |x, y, z, char|
        n_chars = map.cube_neighbors(x, y, z).map do |n|
          n[:char]
        end
        n_active = n_chars.count(ACTIVE)
        if char == ACTIVE
          if n_active == 2 || n_active == 3
            map.set(x, y, z, ACTIVE, 1)
          else
            map.set(x, y, z, INACTIVE, 1)
          end
        else
          if n_active == 3
            map.set(x, y, z, ACTIVE, 1)
          else
            map.set(x, y, z, INACTIVE, 1)
          end
        end
      end # each_char
      map.step
    end
  end

  alias FourD = {x: Int16, y: Int16, z: Int16, w: Int16}

  def draw_space(space : Space)
    puts "\nt=#{space.time}, size=#{space.state.size}"
    return
    sorter = ->(p : FourD, tile : Int8) {
      [-1*p[:w],-1*p[:z],-1*p[:y],p[:x]]
    }
    last_y = Z
    space.each_char(sorter) do |fd, char|
      unless fd[:w] == Z && fd[:z] == Z
        next
      end
      if last_y != fd[:y]
        puts
      end
      last_y = fd[:y]
      print char
    end
    puts
  end

  def part2(file)
    map_lines = File.read_lines(file)
    space = Space(FourD).new([INACTIVE,ACTIVE])
    num_lines = map_lines.size
    map_lines.each.with_index do |line, y|
      line.each_char.with_index do |char, x|
        space.set({x: x.to_i16, y: (num_lines - y - 1).to_i16, z: 0_i16, w: 0_i16}, char)
      end
    end

    loop do
      if space.time == 7
        return space.count_tile(ACTIVE)
      end
      draw_space space
      sleep 0.5
      expand = Array(FourD).new
      space.each_char do |p, char|
        n_chars = Array(Char).new
        [Z, P, N].each_repeated_permutation(size: 4, reuse: true) do |d|
          next if d == [Z, Z, Z, Z]
          p_neighbor = {
            x: p[:x] + d[0],
            y: p[:y] + d[1],
            z: p[:z] + d[2],
            w: p[:w] + d[3]
          }
          c = space.get_char(p_neighbor)
          if [ACTIVE, INACTIVE].includes?(c)
            n_chars << c
          else
            expand << p_neighbor
          end
        end
        space.time_offset = 1
        if space.time == 0
          space.set(p, char)
        else
          n_active = n_chars.count(ACTIVE)
          activity = 
            if char == ACTIVE
              [2, 3].includes?(n_active) ? ACTIVE : INACTIVE
            else
              n_active == 3 ? ACTIVE : INACTIVE
            end
          space.set(p, activity)
        end
        space.time_offset = 0
      end # each_char
      space.time_offset = 1
      expand.uniq!
      #puts "expand #{expand.size}"
      expand.each do |p|
        #puts "set #{p}"
        space.set(p, INACTIVE)
      end
      space.time_offset = 0
      space.step
    end
  end
end
