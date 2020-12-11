class Map
  alias StateRow = Hash(Int16, Int8)
  alias State = Hash(Int16, StateRow)
  def_clone
  UNKNOWN = '?'
  property time
  property states

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
  end

  # `map` is expected to be a multi-line string, e.g. a heredoc
  def import(map : String)
    map.split("\n").each.with_index do |line, y|
      line.chars.each.with_index do |char, x|
        next unless @tiles.values.includes?(char)
        set x.to_i16, y.to_i16, char
      end
    end
  end

  def state(time_offset = 0)
    states[time + time_offset]
  end

  def step
    self.time += 1
    @states.push State.new # t + 1
  end

  def count(tile : Int8|Char)
    tile = @tiles.key_for(tile) if tile.is_a? Char
    count = 0
    all_y.min.to(all_y.max) do |y|
      all_x.min.to(all_x.max) do |x|
        count += 1 if get(x, y) == tile
      end
    end
    count
  end

  def neighbors(x : Int16, y : Int16, diagonal = false)
    neighboring_tiles = [
      {x: 0, y: -1},
      {x: 0, y: 1},
      {x: -1, y: 0},
      {x: 1, y: 0}
    ]
    if diagonal
      neighboring_tiles.concat([
        {x: -1, y: -1},
        {x: -1, y: 1},
        {x: 1, y: -1},
        {x: 1, y: 1}
      ])
    end
    neighboring_tiles.map do |d|
      tile = get( x + d[:x], y + d[:y] )
      next if tile.nil?
      {
        x: x + d[:x],
        y: y + d[:y],
        tile: tile,
        char: @tiles[tile]
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
            char: @tiles[tile]
          }
        end
        x2 = x2 + d[:x]
        y2 = y2 + d[:y]
        tile = get(x2, y2)
      end
      next seen
    end.compact
  end

  def find(tile : Int8|Char)
    tile = @tiles.key_for(tile) if tile.is_a? Char
    all_y.min.to(all_y.max) do |y|
      all_x.min.to(all_x.max) do |x|
        if get(x, y) == tile
          return {x: x, y: y} 
        end
      end
    end
    nil
  end

  def unset(x : Int16, y : Int16, time_offset = 0)
    s = state(time_offset)
    x = x.to_i16
    y = y.to_i16
    return if (x.nil? || y.nil?)
    return if !s.has_key?(y)
    return if !s[y].has_key?(x)
    s[y].delete(x)
  end

  def set(x : Int16, y : Int16, tile : Int8|Char|Nil, time_offset = 0)
    s = state(time_offset)
    tile = @tiles.key_for(tile) if tile.is_a? Char
    return false if tile.nil?
    s[y] = StateRow.new if !s.has_key?(y)
    s[y][x] = tile
    true
  end

  def get_char(x : Int16, y : Int16, time_offset = 0)
    if tile = get(x,y)
      @tiles[tile]
    else
      UNKNOWN
    end
  end

  def get(x : Int16, y : Int16, time_offset = 0)
    s = state(time_offset)
    x = x.to_i16
    y = y.to_i16
    return nil if !s.has_key?(y)
    return nil if !s[y].has_key?(x)
    s[y][x]
  end

  def all_y(time_offset = 0)
    s = state(time_offset)
    s.keys
  end
  def all_x(time_offset = 0)
    s = state(time_offset)
    s.values.flatten.map(&.keys).flatten
  end

  def draw(speed = 0.05)
    s = state
    #`clear`
    all_y.min.to(all_y.max) do |y|
      all_x.min.to(all_x.max) do |x|
        if s.has_key?(y) && s[y].has_key?(x)
          tile = s[y][x]
          print @tiles.has_key?(tile) ? @tiles[tile] : UNKNOWN
          next
        end
        print ' '
      end
      puts
    end
    puts
    sleep speed
  end

  def each_char
    each do |x, y, tile|
      next if tile.nil?
      yield x, y, @tiles[tile]
    end
  end

  def each
    all_y.min.to(all_y.max) do |y|
      all_x.min.to(all_x.max) do |x|
        yield x, y, get(x, y)
      end
    end
  end
end
