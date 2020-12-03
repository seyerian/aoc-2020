require "../spec_helper"

describe Aoc2020::One do
  describe "::part1" do
    it "equals 719796" do
      subject = Aoc2020::One.new
      subject.part1(subject.real_input).should eq 719796
    end
  end
  describe "::part2" do
    it "equals 144554112" do
      subject = Aoc2020::One.new
      subject.part2(subject.real_input).should eq 144554112
    end
  end
end
