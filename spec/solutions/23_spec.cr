require "../spec_helper"

describe Aoc2020::TwentyThree do
  describe "#part1" do
    it "passes example input" do
      s23.part1(s23.example_input).should eq "67384529"
    end
    it "passes real input" do
      s23.part1(s23.real_input).should eq "49576328"
    end
  end
  describe "#part2" do
    # slow
    #it "passes example inputs" do
    #  s23.part2(s23.example_input).should eq 149245887792
    #end
    # slow
    #it "passes real input" do
    #  s23.part2(s23.real_input).should eq 511780369955
    #end
  end
end
