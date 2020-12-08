class Aoc2020::Seven < Aoc2020::Solution
  class Bag
    property name, contents

    def initialize(@name : String, @contents : Array(Tuple(Int32, String)))
    end
    
    def contains?(bag_name, bags)
      @contents.each do |content|
        bag = bags.find { |b| b.name == content[1] }
        next if bag.nil?
        return true if bag.name == bag_name
        return true if bag.contains?(bag_name, bags)
      end
      false
    end

    def contents_count(bags)
      return 0 if contents.none?
      contents.sum do |c|
        bag = bags.find { |b| b.name == c[1] }
        raise "error" if bag.nil?
        c[0] + c[0] * bag.contents_count(bags)
      end
    end
  end

  def parse_input(file)
    pat = /\A(\w+ \w+) bags contain ((?:(?:\d+ \w+ \w+ bags?|no other bags)[,\. ]*)*)\z/
    parsed = InputParsers.pattern(file, pat) do |m|
      bags = m[2][0..-2].gsub(" bags","").gsub(" bag","").split(", ")
      if bags == ["no other"]
        bags = Array(Tuple(Int32, String)).new
      else
        bags = bags.map do |qty_bag|
          qbm = qty_bag.match(/\A(\d+) (\w+ \w+)\z/)
          raise "error" if qbm.nil?
          {qbm[1].to_i32, qbm[2]}
        end
      end
      {
        m[1],
        bags
      }
    end
    parsed.map do |i|
      raise "error" if i.nil?
      Bag.new(i[0], i[1])
    end
  end

  def part1(bags)
    bags.count do |bag|
      bag.contains? "shiny gold", bags
    end
  end

  def part2(bags)
    shiny_gold = bags.find { |b| b.name == "shiny gold" }
    raise "error" if shiny_gold.nil?
    shiny_gold.contents_count bags
  end
end
