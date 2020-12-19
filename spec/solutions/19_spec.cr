require "../spec_helper"

describe Aoc2020::Nineteen do
  describe "#part1" do
    it "passes example input" do
      s19.part1(s19.example_input).should eq 2
    end
    it "passes real input" do
      s19.part1(s19.real_input).should eq 180
    end
  end
  describe "#part2" do
    it "passes example inputs" do
      s19.part2(s19.input("example/19b")).should eq 12
    end
    it "passes real input" do
      s19.part2(s19.real_input).should eq 323
    end
  end
end
