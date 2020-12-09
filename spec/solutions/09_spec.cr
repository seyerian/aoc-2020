require "../spec_helper"

describe Aoc2020::Nine do
  describe "::part1" do
    it "passes example input" do
      s9.part1(s9.example_input, 5).should eq 127
    end
    it "passes real input" do
      s9.part1(s9.real_input, 25).should eq 70639851
    end
  end
  describe "::part2" do
    it "passes example input" do
      s9.part2(s9.example_input, 5).should eq 62
    end
    it "passes real input" do
      s9.part2(s9.real_input, 25).should eq 8249240
    end
  end
end
