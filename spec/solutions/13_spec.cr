require "../spec_helper"

describe Aoc2020::Thirteen do
  describe "#part1" do
    it "passes example input" do
      s13.part1(s13.example_input).should eq 295
    end
    it "passes real input" do
      s13.part1(s13.real_input).should eq 3966
    end
  end
  describe "#part2" do
    it "passes example inputs" do
      s13.part2(s13.example_input).should eq 1068781
      s13.part2(s13.example_input("13b")).should eq 3417
      s13.part2(s13.example_input("13c")).should eq 754018
      s13.part2(s13.example_input("13d")).should eq 779210
      s13.part2(s13.example_input("13e")).should eq 1261476
      s13.part2(s13.example_input("13f")).should eq 1202161486
    end
    it "passes real input" do
      s13.part2(s13.real_input).should eq 800177252346225
    end
  end
end
