require "../spec_helper"

describe Aoc2020::Four do
  describe "#valid?" do
    describe "byr (Birth Year) - four digits; at least 1920 and at most 2002." do
      it "fails letters" do
        s4.valid?("byr", "abcd").should eq false
      end
      it "fails 1919" do
        s4.valid?("byr", "1919").should eq false
      end
      it "fails 2003" do
        s4.valid?("byr", "2003").should eq false
      end
      it "passes 2000" do
        s4.valid?("byr", "2000").should eq true
      end
    end
    describe "iyr (Issue Year) - four digits; at least 2010 and at most 2020." do
      it "fails letters" do
        s4.valid?("iyr", "abcd").should eq false
      end
      it "fails 2009" do
        s4.valid?("iyr", "2009").should eq false
      end
      it "fails 2021" do
        s4.valid?("iyr", "2021").should eq false
      end
      it "passes 2015" do
        s4.valid?("iyr", "2015").should eq true
      end
    end
    describe "eyr (Expiration Year) - four digits; at least 2020 and at most 2030." do
      it "fails letters" do
        s4.valid?("eyr", "abcd").should eq false
      end
      it "fails 2019" do
        s4.valid?("eyr", "2019").should eq false
      end
      it "fails 2031" do
        s4.valid?("eyr", "2031").should eq false
      end
      it "passes 2025" do
        s4.valid?("eyr", "2025").should eq true
      end
    end
    describe "hgt (Height) - a number followed by either cm or in:" do
      describe "If cm, the number must be at least 150 and at most 193." do
        it "fails 149" do
          s4.valid?("hgt", "149cm").should eq false
        end
        it "fails 194" do
          s4.valid?("hgt", "194cm").should eq false
        end
        it "passes 170" do
          s4.valid?("hgt", "170cm").should eq true
        end
      end
      describe "If in, the number must be at least 59 and at most 76." do
        it "fails 58" do
          s4.valid?("hgt", "58in").should eq false
        end
        it "fails 77" do
          s4.valid?("hgt", "77in").should eq false
        end
        it "passes 70" do
          s4.valid?("hgt", "70in").should eq true
        end
      end
    end
    describe "hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f." do
      it "fails 5 hex chars" do
        s4.valid?("hcl", "#012af").should eq false
      end
      it "fails 7 hex chars" do
        s4.valid?("hcl", "#09876af").should eq false
      end
      it "passes 6 hex chars" do
        s4.valid?("hcl", "#0123af").should eq true
      end
    end
    describe "ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth." do
      it "passes each valid color" do
        ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].each do |color|
          s4.valid?("ecl", color).should eq true
        end
      end
      it "fails invalid color" do
        s4.valid?("ecl", "ylw").should eq false
      end
    end
    describe "pid (Passport ID) - a nine-digit number, including leading zeroes." do
      it "fails 8-digit number" do
        s4.valid?("pid", "01234567").should eq false
      end
      it "fails 10-digit number" do
        s4.valid?("pid", "0123456789").should eq false
      end
      it "fails 9 letters" do
        s4.valid?("pid", "abcdefghi").should eq false
      end
      it "passes 9-digit number" do
        s4.valid?("pid", "012345678").should eq true
      end
    end
    describe "cid (Country ID) - ignored, missing or not." do
    end
  end
  describe "#part1" do
    it "passes example input" do
      s4.part1(s4.example_input).should eq 2
    end
    it "passes real input" do
      s4.part1(s4.real_input).should eq 208
    end
  end
  describe "#part2" do
    it "passes example input" do
      s4.part2(
        s4.parse_input("inputs/example/04b")
      ).should eq 4
    end
    it "passes real input" do
      s4.part2(s4.real_input).should eq 167
    end
  end
end
