require "../spec_helper"

describe Aoc2020::TwentyFour do
  describe "#part1" do
    it "passes example input" do
      s24.part1(s24.example_input).should eq 10
    end
    it "passes real input" do
      s24.part1(s24.real_input).should eq 538
    end
  end
  describe "#part2" do
    it "passes example inputs" do
      s24.part2(s24.example_input).should eq 2208
    end
    it "passes real input" do
      s24.part2(s24.real_input).should eq 4259
    end
  end
end
