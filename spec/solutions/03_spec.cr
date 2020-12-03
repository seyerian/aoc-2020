require "../spec_helper"

describe Aoc2020::Three do
  describe "::part1" do
    it "passes example input" do
      subject = Aoc2020::Three.new
      subject.part1(subject.example_input).should eq 7
    end
    it "passes real input" do
      subject = Aoc2020::Three.new
      subject.part1(subject.real_input).should eq 294
    end
  end
  describe "::part2" do
    it "passes example input" do
      subject = Aoc2020::Three.new
      subject.part2(subject.example_input).should eq 336
    end
    it "passes real input" do
      subject = Aoc2020::Three.new
      subject.part2(subject.real_input).should eq 5774564250
    end
  end
end
