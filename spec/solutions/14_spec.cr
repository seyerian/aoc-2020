require "../spec_helper"

describe Aoc2020::Fourteen do
  describe "#part1" do
    it "passes example input" do
      s14.part1(s14.example_input).should eq 165
    end
    it "passes real input" do
      s14.part1(s14.real_input).should eq 17765746710228
    end
  end
  describe "#part2" do
    it "passes example inputs" do
      s14.part2(s14.input("example/14b")).should eq 208
    end
    it "passes real input" do
      s14.part2(s14.real_input).should eq 4401465949086
    end
  end
end
