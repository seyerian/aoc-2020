require "../spec_helper"

describe Aoc2020::TwentyOne do
  describe "#part1" do
    it "passes example input" do
      s21.part1(s21.example_input).should eq 5
    end
    it "passes real input" do
      s21.part1(s21.real_input).should eq 2724
    end
  end
  describe "#part2" do
    it "passes example inputs" do
      s21.part2(s21.example_input).should eq "mxmxvkd,sqjhc,fvjkl"
    end
    it "passes real input" do
      s21.part2(s21.real_input).should eq "xlxknk,cskbmx,cjdmk,bmhn,jrmr,tzxcmr,fmgxh,fxzh"
    end
  end
end
