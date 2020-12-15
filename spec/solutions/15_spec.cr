require "../spec_helper"

describe Aoc2020::Fifteen do
  describe "#part1" do
    it "passes example input" do
      s15.part1(s15.example_input).should eq 436
      #s15.part1(s15.input("example/15b")).should eq 1
      #s15.part1(s15.input("example/15c")).should eq 10
      #s15.part1(s15.input("example/15d")).should eq 27
      #s15.part1(s15.input("example/15e")).should eq 78
      #s15.part1(s15.input("example/15f")).should eq 438
      #s15.part1(s15.input("example/15g")).should eq 1836
    end
    it "passes real input" do
      s15.part1(s15.real_input).should eq 376
    end
  end
  describe "#part2" do
    it "passes example inputs" do
      s15.part2(s15.example_input).should eq 175594
      #s15.part2(s15.input("example/15b")).should eq 2578
      #s15.part2(s15.input("example/15c")).should eq 3544142
      #s15.part2(s15.input("example/15d")).should eq 261214
      #s15.part2(s15.input("example/15e")).should eq 6895259
      #s15.part2(s15.input("example/15f")).should eq 18
      #s15.part2(s15.input("example/15g")).should eq 362
    end
    it "passes real input" do
      s15.part2(s15.real_input).should eq 323780
    end
  end
end
