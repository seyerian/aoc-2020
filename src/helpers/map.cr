class Map
  alias StateRow = Hash(Int16, Int8) # x
  alias StatePlane = Hash(Int16, StateRow) # y
  alias State = Hash(Int16, StatePlane) # z
  def_clone
  UNKNOWN = '?'
  property time
  property states
  property default_tile : Int8
  property out_of_bounds

  def initialize(tiles : Array(Char))
    tiles_h = Hash(Int8, Char).new
    tiles.each.with_index do |tile, i|
      tiles_h[tile.ord.to_i8] = tile
    end
    initialize tiles_h
  end

  def initialize(@tiles : Hash(Int8, Char))
    @states = Array(State).new
    @states.push State.new
    @states.push State.new # t + 1
    @time = 0
    @default_tile = @tiles.keys.first
    @out_of_bounds = false
  end

  # `map` is expected to be a multi-line string, e.g. a heredoc
  def import(map : String)
    map.split("\n").each.with_index do |line, y|
      line.chars.each.with_index do |char, x|
        next unless @tiles.values.includes?(char)
        set x.to_i16, y.to_i16, 0_i16, char
      end
    end
  end

  def state(time_offset = 0)
    @states[time + time_offset]
  end

  def step
    self.time += 1
    @states.push State.new # t + 1
  end

  def count(tile : Int8|Char)
    tile = @tiles.key_for(tile) if tile.is_a? Char
    count = 0
    each do |x, y, z, i|
      count += 1 if i == tile
    end
    count
  end

  def cube_neighbors(x : Int16, y : Int16, z : Int16)
    neighbors(x, y, z, true) + neighbors(x, y, z - 1, true, true) + neighbors(x, y, z + 1, true, true)
  end

  def neighbors(x : Int16, y : Int16, diagonal = false, center = false)
    neighbors(x, y, 0_i16, diagonal, center)
  end

  def neighbors(x : Int16, y : Int16, z : Int16, diagonal = false, center = false)
    neighboring_tiles = [
      {x: 0, y: -1, z: 0},
      {x: 0, y: 1, z: 0},
      {x: -1, y: 0, z: 0},
      {x: 1, y: 0, z: 0}
    ]
    if diagonal
      neighboring_tiles.concat([
        {x: -1, y: -1, z: 0},
        {x: -1, y: 1, z: 0},
        {x: 1, y: -1, z: 0},
        {x: 1, y: 1, z: 0}
      ])
    end
    if center
      neighboring_tiles.push({x: 0, y: 0, z: 0})
    end
    neighboring_tiles.map do |d|
      tile = get( x + d[:x], y + d[:y], z: z + d[:z] )
      {
        x: x + d[:x],
        y: y + d[:y],
        z: z + d[:z],
        tile: tile,
        char: tile_char(tile)
      }
    end.compact
  end

  def lines_of_sight(x : Int16, y : Int16, targets = [] of Int8|Char, diagonal = false)
    targets = targets.map do |t|
      t.is_a?(Char) ? @tiles.key_for(t) : t
    end
    dirs = [ {x: 0, y: -1}, {x: 0, y: 1}, {x: -1, y: 0}, {x: 1, y: 0} ]
    if diagonal
      dirs.concat([ {x: -1, y: -1}, {x: -1, y: 1}, {x: 1, y: -1}, {x: 1, y: 1} ])
    end
    dirs.map do |d|
      x2 = x + d[:x]
      y2 = y + d[:y]
      seen = nil
      tile = get(x2, y2)
      until seen || tile.nil?
        if targets.includes?(tile)
          seen = {
            x: x2,
            y: y2,
            tile: tile,
            char: tile_char(tile)
          }
        end
        x2 = x2 + d[:x]
        y2 = y2 + d[:y]
        tile = get(x2, y2)
      end
      next seen
    end.compact
  end

  def find(tile : Int8|Char, z : Int16 = 0_i16)
    tile = @tiles.key_for(tile) if tile.is_a? Char
    each(z) do |x, y, z, i|
      if i == tile
        return {x: x, y: y, z: z} 
      end
    end
    nil
  end

  def unset(x : Int16, y : Int16, z : Int16 = 0_i16, time_offset = 0)
    s = state(time_offset)
    i = get(x, y, z, time_offset)
    if i
      s[z][y].delete(x)
    end
  end

  def set(x : Int16, y : Int16, z : Int16, tile : Int8|Char|Nil = nil, time_offset = 0)
    s = state(time_offset)
    tile = @tiles.key_for(tile) if tile.is_a? Char
    return false if tile.nil?
    s[z] = StatePlane.new if !s.has_key?(z)
    s[z][y] = StateRow.new if !s[z].has_key?(y)
    s[z][y][x] = tile
    true
  end

  def tile_char(tile : Int8 | Nil)
    tile ||= default_tile
    @tiles.has_key?(tile) ? @tiles[tile] : UNKNOWN
  end

  def get_char(x : Int16, y : Int16, z : Int16 = 0_i16, time_offset = 0)
    tile = get(x, y, z, time_offset)
    tile_char(tile)
  end

  def get(x : Int16, y : Int16, z : Int16 = 0_i16, time_offset = 0)
    s = state(time_offset)
    return nil if !s.has_key?(z)
    return nil if !s[z].has_key?(y)
    return nil if !s[z][y].has_key?(x)
    s[z][y][x]
  end

  def extend_bounds(range : Array(Int16))
    min = range.min
    max = range.max
    range.unshift(min - 1)
    range.push(max + 1)
    range 
  end

  def all_z(time_offset = 0)
    s = state(time_offset)
    z = s.keys
    out_of_bounds ? extend_bounds(z) : z
  end
  def all_y(time_offset = 0)
    s = state(time_offset)
    y = [] of Int16
    s.each do |z, plane|
      y.concat plane.keys
    end
    y.uniq!
    out_of_bounds ? extend_bounds(y) : y
  end
  def all_x(time_offset = 0)
    s = state(time_offset)
    x = [] of Int16
    s.each do |z, plane|
      x.concat plane.values.flatten.map(&.keys).flatten
    end
    x.uniq!
    out_of_bounds ? extend_bounds(x) : x
  end

  def draw(speed = 0.05, z : Int16 = 0_i16)
    s = state
    #`clear`
    all_y.min.to(all_y.max) do |y|
      all_x.min.to(all_x.max) do |x|
        print get_char(x, y, z)
      end
      puts
    end
    puts
    sleep speed
  end

  def each_char
    each do |x, y, z, tile|
      yield x, y, z, tile_char(tile)
    end
  end

  def each 
    all_z.min.to(all_z.max) do |z|
      each(z) do |x, y, tile|
        yield x, y, z, tile
      end
    end
  end
   
  def each_char(z : Int16)
    each(z) do |x, y, tile|
      yield x, y, tile_char(tile)
    end
  end

  def each(z : Int16)
    all_y.min.to(all_y.max) do |y|
      all_x.min.to(all_x.max) do |x|
        yield x, y, get(x, y, z)
      end
    end
  end
end
