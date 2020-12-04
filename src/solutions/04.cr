class Aoc2020::Four < Aoc2020::Solution
  FIELDS = [ "byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid", "cid" ]
  REQUIRED_FIELDS = FIELDS - [ "cid" ]

  def parse_input(file)
    passport_lines = [""]
    File.read_lines(file).each do |line|
      if line.empty?
        passport_lines << ""
      else
        l = passport_lines.last 
        l += " " if l != ""
        l += line
        passport_lines[passport_lines.size - 1] = l
      end
    end
    passport_lines.map do |pl|
      pairs = pl.split(" ")
      pairs.map do |pair|
        pair.split(":")
      end.to_h
    end
  end

  def part1(input)
    input.count do |i|
      REQUIRED_FIELDS.all? do |field|
        i.keys.includes?(field)
      end
    end
  end

  def part2(input)
    input.count do |i|
      REQUIRED_FIELDS.all? do |field|
        i.keys.includes?(field) && valid?(field, i[field])
      end
    end
  end

  # byr (Birth Year) - four digits; at least 1920 and at most 2002.
  # iyr (Issue Year) - four digits; at least 2010 and at most 2020.
  # eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
  # hgt (Height) - a number followed by either cm or in:
  # If cm, the number must be at least 150 and at most 193.
  # If in, the number must be at least 59 and at most 76.
  # hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
  # ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
  # pid (Passport ID) - a nine-digit number, including leading zeroes.
  # cid (Country ID) - ignored, missing or not.

  def valid?(field, value)
    v = value
    case field
    when "byr"
      if m = v.match(/\A\d{4}\z/) 
        vi = v.to_i32
        vi >= 1920 && vi <= 2002
      else
        false
      end
    when "iyr"
      if m = v.match(/\A\d{4}\z/)
        vi = v.to_i32
        vi >= 2010 && vi <= 2020
      else
        false
      end
    when "eyr"
      if m = v.match(/\A\d{4}\z/)
        vi = v.to_i32
        vi >= 2020 && vi <= 2030
      else
        false
      end
    when "hgt"
      if m = v.match(/\A(\d{2,3})(cm|in)\z/)
        vi = m[1].to_i32
        unit = m[2]
        valid_cm = unit == "cm" && vi >= 150 && vi <= 193
        valid_in = unit == "in" && vi >= 59 && vi <= 76
        valid_cm || valid_in
      else
        false
      end
    when "hcl"
      m = v.match(/\A#([[:xdigit:]]{6})\z/)
      !m.nil?
    when "ecl"
      m = v.match(/\A(amb|blu|brn|gry|grn|hzl|oth)\z/)
      !m.nil?
    when "pid"
      m = v.match(/\A[[:digit:]]{9}\z/)
      !m.nil?
    end
  end
end
