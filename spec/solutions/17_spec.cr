require "../spec_helper"

describe Aoc2020::Seventeen do
  describe "#part1" do
    it "passes example input" do
      s17.part1(s17.example_input).should eq 112
    end
    it "passes real input" do
      s17.part1(s17.real_input).should eq 295
    end
  end
  describe "#part2" do
    it "passes example inputs" do
      #s17.part2(s17.input("example/16b")).should eq
    end
    it "passes real input" do
      #s17.part2(s17.real_input).should eq 603409823791
    end
  end
end
