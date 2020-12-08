require "../spec_helper"

describe Aoc2020::Eight do
  describe "::part1" do
    it "passes example input" do
      s8.part1(s8.example_input).should eq 5
    end
    it "passes real input" do
      s8.part1(s8.real_input).should eq 1475
    end
  end
  describe "::part2" do
    it "passes example input" do
      s8.part2(s8.example_input).should eq 8
    end
    it "passes real input" do
      s8.part2(s8.real_input).should eq 1270
    end
  end
end
