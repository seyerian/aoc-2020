require "../spec_helper"

describe Aoc2020::Eleven do
  describe "#part1" do
    it "passes example input" do
      s11.part1(s11.example_input).should eq 37
    end
    # NOTE slow
    #it "passes real input" do
    #  s11.part1(s11.real_input).should eq 2251
    #end
  end
  describe "#part2" do
    it "passes example input" do
      s11.part2(s11.example_input).should eq 26
    end
    # NOTE slow
    #it "passes real input" do
    #  s11.part2(s11.real_input).should eq 2019
    #end
  end
end
