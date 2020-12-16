require "../spec_helper"

describe Aoc2020::Sixteen do
  describe "#part1" do
    it "passes example input" do
      s16.part1(s16.example_input).should eq 71
    end
    it "passes real input" do
      s16.part1(s16.real_input).should eq 25961
    end
  end
  describe "#part2" do
    it "passes example inputs" do
      #s16.part2(s16.input("example/16b")).should eq
    end
    it "passes real input" do
      s16.part2(s16.real_input).should eq 603409823791
    end
  end
end
