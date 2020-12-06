require "../spec_helper"

describe Aoc2020::Six do
  describe "::part1" do
    it "passes example input" do
      s6.part1(s6.example_input).should eq 11
    end
    it "passes real input" do
      s6.part1(s6.real_input).should eq 6686
    end
  end
  describe "::part2" do
    it "passes example input" do
      s6.part2(s6.example_input).should eq 6
    end
    it "passes real input" do
      s6.part2(s6.real_input).should eq 3476
    end
  end
end
