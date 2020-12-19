require "../spec_helper"

describe Aoc2020::Eighteen do
  describe "#part1" do
    it "passes example input" do
      s18.part1(s18.example_input).should eq 26457
    end
    it "passes real input" do
      s18.part1(s18.real_input).should eq 24650385570008
    end
  end
  describe "#part2" do
    # it "passes example inputs" do
    #   s18.part2(s18.input("example/16b")).should eq
    # end
    it "passes real input" do
      s18.part2(s18.real_input).should eq 158183007916215
    end
  end
end
