require "../spec_helper"

describe Aoc2020::Five do
  describe "#seat_id" do
    it "passes examples seats" do
      s5.seat_id("BFFFBBFRRR").should eq 567
      s5.seat_id("FFFBBBFRRR").should eq 119
      s5.seat_id("BBFFBBFRLL").should eq 820
    end
  end
  describe "::part1" do
    #it "passes example input" do
    #  subject.part1(subject.example_input).should eq 7
    #end
    it "passes real input" do
      s5.part1(s5.real_input).should eq 883
    end
  end
  describe "::part2" do
    #it "passes example input" do
    #  subject.part2(subject.example_input).should eq 336
    #end
    it "passes real input" do
      s5.part2(s5.real_input).should eq 532
    end
  end
end
