require "../spec_helper"

describe Aoc2020::Eleven do
  describe "::part1" do
    it "passes example input" do
      s12.part1(s12.example_input).should eq 25
    end
    it "passes real input" do
      s12.part1(s12.real_input).should eq 1482
    end
  end
  describe "::part2" do
    it "passes example input" do
      s12.part2(s12.example_input).should eq 286
    end
    it "passes real input" do
      s12.part2(s12.real_input).should eq 48739
    end
  end
end
