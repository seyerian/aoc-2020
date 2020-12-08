require "../spec_helper"

describe Aoc2020::Seven do
  describe "::part1" do
    it "passes example input" do
      s7.part1(s7.example_input).should eq 4
    end
    it "passes real input" do
      s7.part1(s7.real_input).should eq 205
    end
  end
  describe "::part2" do
    it "passes example input" do
      s7.part2(s7.example_input).should eq 32
    end
    it "passes real input" do
      s7.part2(s7.real_input).should eq 80902
    end
  end
end
