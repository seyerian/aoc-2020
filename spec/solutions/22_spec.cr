require "../spec_helper"

describe Aoc2020::TwentyTwo do
  describe "#part1" do
    it "passes example input" do
      s22.part1(s22.example_input).should eq 306
    end
    it "passes real input" do
      s22.part1(s22.real_input).should eq 32824
    end
  end
  describe "#part2" do
    it "passes example inputs" do
      s22.part2(s22.example_input).should eq 291
    end
    # slow
    #it "passes real input" do
    #  s22.part2(s22.real_input).should eq "xlxknk,cskbmx,cjdmk,bmhn,jrmr,tzxcmr,fmgxh,fxzh"
    #end
  end
end
