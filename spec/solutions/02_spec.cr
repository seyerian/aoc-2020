require "../spec_helper"

describe Aoc2020::Two do
  describe "#part1" do
    it "equals 454" do
      s2.part1(s2.real_input).should eq 454
    end
  end
  describe "#part2" do
    it "equals 649" do
      s2.part2(s2.real_input).should eq 649
    end
  end
end
