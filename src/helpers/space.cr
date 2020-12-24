class Space(Spatial, Cell)

  UNKNOWN = '?'

  def_clone

  property time : Int32
  property time_offset : Int32
  property states : Array(Hash(Spatial, Cell))

  def initialize
    @states = Array(Hash(Spatial, Cell)).new
    @states.push Hash(Spatial, Cell).new
    @states.push Hash(Spatial, Cell).new # t + 1
    @time = 0
    @time_offset = 0
  end

  def state=(s)
    @states[time + time_offset] = s
  end

  def state
    @states[time + time_offset]
  end

  def step
    self.time += 1
    self.time_offset = 0
    @states.push Hash(Spatial, Cell).new
  end

  def count
    #each.select { |s,t| yield(t) }
    count = 0
    each do |s, cell|
      count += 1 if yield(s, cell)
    end
    count
  end

  def count_cell(cell : Cell)
    count do |s, c|
      c == cell
    end
  end

  def find
    each do |s, c|
      if yield(s, c)
        return s, c
      end
    end
    nil
  end

  def find_spatial
    r = find do |s, c|
      yield(s,c)
    end
    if r
      r[0]
    end
  end

  def find_cell
    r = find do |s, c|
      yield(s,c)
    end
    if r
      r[1]
    end
  end

  def get(s : Spatial)
    state.has_key?(s) ? state[s] : nil
  end

  def set(s : Spatial, c : Cell)
    state[s] = c
  end

  def unset(s : Spatial)
    state.delete(s)
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

  def select
    state.select do |s, c|
      yield(s, c)
    end
  end

  def each(sorter = nil)
    if sorter
      state.to_a.sort_by(&sorter).each do |s, c|
        yield(s, c)
      end
    else
      state.each do |s, c|
        yield(s, c)
      end
    end
  end

  def map!
    s = Hash(Spatial, Cell).new
    state.each do |spatial, cell|
      new_spatial, new_cell = yield(spatial, cell)
      s[new_spatial] = new_cell
    end
    self.state = s
    self
  end
end
