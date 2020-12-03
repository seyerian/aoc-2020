require "../spec_helper"

describe Aoc2020::Two do
  describe "::part1" do
    it "equals 454" do
      subject = Aoc2020::Two.new
      subject.part1(subject.real_input).should eq 454
    end
  end
  describe "::part2" do
    it "equals 649" do
      subject = Aoc2020::Two.new
      subject.part2(subject.real_input).should eq 649
    end
  end
end
