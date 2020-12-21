class Aoc2020::TwentyOne < Aoc2020::Solution
  def initialize
    @allergen_foods = Hash(String, String).new
  end

  def parse_input(file)
    InputParsers.pattern(file, /\A([\w ]+) \(contains ([\w, ]+)\)\z/) do |m|
      {
        m[1].split,
        m[2].split(", "),
      }
    end
  end

  def part1(input)
    #puts input
    foods = input.map{ |i| i[0] }.reduce(Array(String).new) { |arr, foods|
      arr.concat(foods)
    }.uniq
    allergens = input.map{ |i| i[1] }.reduce(Array(String).new) { |arr, allergens|
      arr.concat(allergens)
    }.uniq
    allergen_possibles = Hash(String, Array(String)).new
    allergens.each do |allergen|
      food_lists = input.select { |i|
        i[1].includes?(allergen)
      }.map { |i| i[0] }
      allergen_possibles[allergen] = food_lists.reduce do |master_list, food_list|
        master_list & food_list
      end
    end
    until allergen_possibles.empty?
      allergen_possibles.each do |allergen, possible_foods|
        if possible_foods.size == 1
          @allergen_foods[allergen] = possible_foods.first
        end
      end
      @allergen_foods.each do |allergen, food|
        allergen_possibles.delete(allergen)
        allergen_possibles.each do |allergen, possible_foods|
          possible_foods.delete(food)
        end
      end
    end
    foods_w_allergens = @allergen_foods.map{|a, f| f}
    foods_wo_allergens = foods - foods_w_allergens
    appearances = 0
    foods_wo_allergens.each do |food_wo_allergen|
      input.each do |i|
        appearances += 1 if i[0].includes?(food_wo_allergen)
      end
    end
    appearances
  end

  def part2(input)
    part1(input)
    @allergen_foods.to_a.sort_by { |a, f| a }.map { |a,f| f}.join(',')
  end
end
