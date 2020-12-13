require "../spec_helper"

describe Aoc2020::Three do
  describe "#part1" do
    it "passes example input" do
      s3.part1(s3.example_input).should eq 7
    end
    it "passes real input" do
      s3.part1(s3.real_input).should eq 294
    end
  end
  describe "#part2" do
    it "passes example input" do
      s3.part2(s3.example_input).should eq 336
    end
    it "passes real input" do
      s3.part2(s3.real_input).should eq 5774564250
    end
  end
end
