# rank 5627 on this one

class Aoc2020::Twenty < Aoc2020::Solution
  property max : Int16

  def parse_input(file)
    InputParsers.groups(file)
  end

  def initialize
    @max = 0_i16
    @image = Space({x: Int16, y: Int16, id: Int16}, Tile).new
  end

  def draw_tile(tile : Space)
    sorter = ->(s : Coords, tile : Char) { [-1 * s[:y],s[:x]] }
    last_y = -1
    tile.each(sorter) do |s, c|
      if last_y != s[:y]
        puts unless last_y == -1
      end
      last_y = s[:y]
      print c
    end
    puts
  end

  alias Coords = {x: Int16, y: Int16}
  alias Tile = Space(Coords, Char)
  def part1(groups)
    tiles = Hash(Int16, Tile).new
    @max = groups.first.last.size.to_i16 - 1_i16
    groups.each do |group|
      tile = Tile.new
      id_line = group.shift
      m = id_line.match(/Tile (\d+):/)
      next if m.nil?
      id = m[1].to_i16
      group.each.with_index do |line, y|
        line.each_char.with_index do |char, x|
          tile.set({x: x.to_i16, y: (max - y.to_i16).to_i16}, char)
        end
      end
      tiles[id] = tile
    end

    first_id, first_tile = tiles.shift
    @image.set({x: 0_i16, y: 0_i16, id: first_id.to_i16}, first_tile)
    until tiles.empty?
      delete = [] of Int16
      tiles.each do |id, tile|
        @image.each do |img_tile_coords, img_tile|
          if check_match(img_tile_coords, img_tile, tile, id)
            delete << id
            break
          end
          rotate_tile(tile)
          if check_match(img_tile_coords, img_tile, tile, id)
            delete << id
            break
          end
          rotate_tile(tile)
          if check_match(img_tile_coords, img_tile, tile, id)
            delete << id
            break
          end
          rotate_tile(tile)
          if check_match(img_tile_coords, img_tile, tile, id)
            delete << id
            break
          end
          rotate_tile(tile)
          flip_tile(tile)
          if check_match(img_tile_coords, img_tile, tile, id)
            delete << id
            break
          end
          rotate_tile(tile)
          if check_match(img_tile_coords, img_tile, tile, id)
            delete << id
            break
          end
          rotate_tile(tile)
          if check_match(img_tile_coords, img_tile, tile, id)
            delete << id
            break
          end
          rotate_tile(tile)
          if check_match(img_tile_coords, img_tile, tile, id)
            delete << id
            break
          end
          rotate_tile(tile)
          flip_tile(tile)
        end
      end
      delete.each do |id|
        tiles.delete(id)
      end
    end
    x_min = 0
    x_max = 0
    y_min = 0
    y_max = 0
    @image.each do |s, c|
      x_min = s[:x] if s[:x] < x_min
      x_max = s[:x] if s[:x] > x_max
      y_min = s[:y] if s[:y] < y_min
      y_max = s[:y] if s[:y] > y_max
    end
    
    image_x_offset = 0 - x_min
    image_y_offset = 0 - y_min
    @image.map! do |s, c|
      next {x: s[:x] + image_x_offset, y: s[:y] + image_y_offset, id: s[:id]}, c
    end

    corner_ids = [] of Int16
    @image.each do |s, c|
      if s[:x] == 0 && s[:y] == 0
        corner_ids << s[:id]
      elsif s[:x] == 0 && s[:y] == y_max + image_y_offset
        corner_ids << s[:id]
      elsif s[:x] == x_max + image_x_offset && s[:y] == 0
        corner_ids << s[:id]
      elsif s[:x] == x_max + image_x_offset && s[:y] == y_max + image_y_offset
        corner_ids << s[:id]
      end
    end

    corner_ids.reduce(1_i64) do |product, id|
      product * id
    end
  end

  def left_edge(tile : Tile)
    tile.select{ |s, c| s[:x] == 0 }.to_a.sort_by{ |s, c| s[:y] }.map{ |s, c| c }.join
  end

  def right_edge(tile : Tile)
    tile.select{ |s, c| s[:x] == @max }.to_a.sort_by{ |s, c| s[:y] }.map{ |s, c| c }.join
  end

  def bottom_edge(tile : Tile)
    tile.select{ |s, c| s[:y] == 0 }.to_a.sort_by{ |s, c| s[:x] }.map{ |s, c| c }.join
  end

  def top_edge(tile : Tile)
    tile.select{ |s, c| s[:y] == @max }.to_a.sort_by{ |s, c| s[:x] }.map{ |s, c| c }.join
  end

  def check_match(img_tile_coords, img_tile, tile, id)
    offset = nil

    if right_edge(tile) == left_edge(img_tile)
      offset = {x: -1, y: 0} 
    end

    if offset.nil?
      if left_edge(tile) == right_edge(img_tile)
        offset = {x: 1, y: 0} 
      end
    end

    if offset.nil?
      if top_edge(tile) == bottom_edge(img_tile)
        offset = {x: 0, y: -1}
      end
    end

    if offset.nil?
      if bottom_edge(tile) == top_edge(img_tile)
        offset = {x: 0, y: 1} 
      end
    end

    if offset.nil?
      return false
    else
      x = img_tile_coords[:x] + offset[:x]
      y = img_tile_coords[:y] + offset[:y]
      existing = @image.find_cell do |coords, cell|
        coords[:x] == x && coords[:y] == y
      end
      if existing
        return false
      else
        fits = true
        above = @image.find_cell do |it|
          it[:x] == x && it[:y] == y + 1
        end
        if above
          if bottom_edge(above) != top_edge(tile)
            fits = false
          end
        end
        below = @image.find_cell do |it|
          it[:x] == x && it[:y] == y - 1
        end
        if below
          if top_edge(below) != bottom_edge(tile)
            fits = false
          end
        end
        left = @image.find_cell do |it|
          it[:x] == x - 1 && it[:y] == y
        end
        if left
          if right_edge(left) != left_edge(tile)
            fits = false
          end
        end
        right = @image.find_cell do |it|
          it[:x] == x + 1 && it[:y] == y
        end
        if right
          if left_edge(right) != right_edge(tile)
            fits = false
          end
        end
        if fits
          @image.set( { x: x, y: y, id: id }, tile )
          return true
        else
          return false
        end
      end
    end
  end

  def flip_tile(tile)
    tile.map! do |spat, cell|
      next {x: (@max - spat[:x]).to_i16, y: spat[:y].to_i16}, cell
    end
  end

  def rotate_tile(tile)
    tile.map! do |spat, cell|
      next {x: (@max - spat[:y]).to_i16, y: spat[:x].to_i16}, cell
    end
  end

  def part2(groups)
    part1(groups)
    map = Tile.new
    image_sorter = ->(s : {x: Int16, y: Int16, id: Int16}, tile : Tile) { [s[:y],s[:x]] }
    tile_sorter = ->(s : Coords, char : Char) { [s[:y],s[:x]] }
    @image.each(image_sorter) do |image_coords, tile|
      tile.each(tile_sorter) do |coords, char|
        next if coords[:x] == 0
        next if coords[:x] == @max
        next if coords[:y] == 0
        next if coords[:y] == @max
        # max 3 (width 4)
        # | x x |
        # 0 2 4
        # x_region = n * (3 - 2 + 1) = n * 2 = 0, 2, 4
        x_region = image_coords[:x] * (@max - 2 + 1)
        x = x_region + (coords[:x] - 1)
        y_region = image_coords[:y] * (@max - 2 + 1)
        y = y_region + (coords[:y] - 1)
        map.set( { x: x, y: y }, char )
      end
    end
    sea_monster = Tile.new
    InputParsers.map("inputs/20_sea_monster").each.with_index do |row, y|
      row.each.with_index do |c, x|
        sea_monster.set({x: x.to_i16, y: (2 - y.to_i16).to_i16}, c)
      end
    end
    sea_monster_body_coords = sea_monster.select{|s, c| c == '#'}.keys
    num_sea_monsters = 0
    rotate_count = 0
    until num_sea_monsters > 0
      num_sea_monsters = count_sea_monsters(map, sea_monster_body_coords)
      rotate_tile(map)
      rotate_count += 1
      flip_tile(map) if rotate_count == 4
    end
    num_hashtags = map.count { |s, c| c == '#' }
    num_hashtags - (num_sea_monsters * sea_monster_body_coords.size)
  end

  def count_sea_monsters(map, body_coords)
    map.count do |s, c|
      body_coords.all? do |coords|
        map.get({x: s[:x] + coords[:x], y: s[:y] + coords[:y]}) == '#'
      end
    end
  end
end
