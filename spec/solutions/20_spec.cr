require "../spec_helper"

def raw_to_tile(raw : String)
  tile = Space({x: Int16, y: Int16}, Char).new
  raw.split("\n").each.with_index do |line, y|
    line.each_char.with_index do |char, x|
      tile.set({x: x.to_i16, y: y.to_i16}, char)
    end
  end
  tile
end

describe Aoc2020::Twenty do
  describe "#flip_tile" do
    it "flips the tile about the y axis" do
      solution = s20
      solution.max = 2_i16
      tile = raw_to_tile(
        <<-TILE
        123
        456
        789
        TILE
      )
      tile2 = raw_to_tile(
        <<-TILE
        321
        654
        987
        TILE
      )
      solution.flip_tile(tile)
      (0_i16..2_i16).each do |x|
        (0_i16..2_i16).each do |y|
          tile.get({x: x, y: y}).should eq tile2.get({x: x, y: y})
        end
      end
    end
  end
  describe "#rotate_tile" do
    it "rotates the tile clockwise" do
      solution = s20
      solution.max = 2_i16
      tile = raw_to_tile(
        <<-TILE
        123
        456
        789
        TILE
      )
      tile2 = raw_to_tile(
        <<-TILE
        741
        852
        963
        TILE
      )
      solution.rotate_tile(tile)
      (0_i16..2_i16).each do |x|
        (0_i16..2_i16).each do |y|
          tile.get({x: x, y: y}).should eq tile2.get({x: x, y: y})
        end
      end
    end
  end
  describe "#part1" do
    #it "passes example input" do
    #  s20.part1(s20.example_input).should eq 2
    #end
    #it "passes real input" do
    #  s20.part1(s20.real_input).should eq 180
    #end
  end
  describe "#part2" do
    #it "passes example inputs" do
    #  s20.part2(s20.input("example/19b")).should eq 12
    #end
    #it "passes real input" do
    #  s20.part2(s20.real_input).should eq 323
    #end
  end
end
