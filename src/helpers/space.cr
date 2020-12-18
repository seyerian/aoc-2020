class Space(P)

  alias Tile = Int8
  #alias State = Hash(P, Tile)

  UNKNOWN = '?'

  def_clone

  property time : Int32
  property time_offset : Int32
  property states : Array(Hash(P, Tile))
  property out_of_bounds : Bool
  property tiles : Hash(Int8, Char)
  property default_tile : Tile

  def initialize(tiles : Array(Char))
    tiles_h = Hash(Int8, Char).new
    tiles.each.with_index do |tile, i|
      tiles_h[tile.ord.to_i8] = tile
    end
    initialize tiles_h
  end

  def initialize(@tiles : Hash(Int8, Char))
    @states = Array(Hash(P, Tile)).new
    @states.push Hash(P, Tile).new
    @states.push Hash(P, Tile).new # t + 1
    @time = 0
    @time_offset = 0
    @default_tile = @tiles.keys.first
    @out_of_bounds = false
  end

  def state
    @states[time + time_offset]
  end

  def step
    self.time += 1
    self.time_offset = 0
    @states.push Hash(P, Tile).new
  end

  def count
    #each.select { |p,t| yield(t) }
    count = 0
    each do |p, tile|
      count += 1 if yield(p, tile)
    end
    count
  end

  def count_tile(tile : Int8|Char)
    tile = @tiles.key_for(tile) if tile.is_a? Char
    count do |p, t|
      t == tile
    end
  end

  #def find(tile : Int8|Char)
  #  tile = @tiles.key_for(tile) if tile.is_a? Char
  #  each do |p, t|
  #    if yield(p, t)
  #      return p
  #    end
  #  end
  #  nil
  #end

  def get(p : P)
    state.has_key?(p) ? state[p] : nil
    #each do |p, t|
    #  if p == this_p
    #    return t
    #  end
    #end
  end

  def set(p : P, tile : Int8|Char)
    tile = @tiles.key_for(tile) if tile.is_a? Char
    state[p] = tile
    #unset(p)
    #state << {p, tile}
  end

  #def add(p : P, tile : Int8|Char)
  #  tile = @tiles.key_for(tile) if tile.is_a? Char
  #  state << {p, tile}
  #end

  def unset(p : P)
    state.delete(p)
  end

  def tile_char(tile : Int8 | Nil)
    #tile ||= default_tile
    @tiles.has_key?(tile) ? @tiles[tile] : UNKNOWN
  end

  def get_char(p)
    tile_char(get(p))
  end

  #def draw(speed = 0.05, z : Int16 = 0_i16)
  #  s = state
  #  #`clear`
  #  all_y.min.to(all_y.max) do |y|
  #    all_x.min.to(all_x.max) do |x|
  #      print get_char(x, y, z)
  #    end
  #    puts
  #  end
  #  puts
  #  sleep speed
  #end

  def each(sorter = nil)
    if sorter
      state.to_h.sort_by(&sorter).each do |p, tile|
        yield(p, tile)
      end
    else
      state.each do |p, tile|
        yield(p, tile)
      end
    end
  end

  def each_char(sorter = nil)
    each(sorter) do |p, tile|
      yield(p, tile_char(tile))
    end
  end
end
