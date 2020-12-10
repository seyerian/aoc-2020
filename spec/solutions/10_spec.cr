require "../spec_helper"

describe Aoc2020::Ten do
  describe "::part1" do
    it "passes example input" do
      a = s10.part1(s10.example_input)
      a[0].should eq 7
      a[1].should eq 5
    end
    it "passes 2nd example input" do
      a = s10.part1(s10.input("example/10b"))
      a[0].should eq 22
      a[1].should eq 10
    end
    it "passes real input" do
      a = s10.part1(s10.real_input)
      a[2].should eq 2277
    end
  end
  describe "::part2" do
    it "passes example input" do
      s10.part2(s10.example_input).should eq 8
    end
    it "passes 2nd example input" do
      s10.part2(s10.input("example/10b")).should eq 19208
    end
    it "passes real input" do
      s10.part2(s10.real_input).should eq 37024595836928
    end
  end
end
