class Aoc2020::TwentyThree < Aoc2020::Solution
  def parse_input(file)
    File.read_lines(file)[0].chars.map(&.to_i32)
  end

  class Cup
    getter label

    def left=(cup : Cup | Nil)
      @left = cup
    end
    def left
      cup = @left
      raise "left cup nil" if cup.nil?
      cup
    end

    def right=(cup : Cup | Nil)
      @right = cup
    end
    def right
      cup = @right
      raise "right cup nil" if cup.nil?
      cup
    end

    def initialize(@label : Int32)
      @right = nil
      @left = nil
    end

    def pick_up
      left = self.left
      right = self.right
      left.right = right
      right.left = left
      self.left = nil
      self.right = nil
    end

    def place_at_right(cup : Cup)
      right = self.right
      self.right = cup
      cup.left = self
      cup.right = right
      right.left = cup
    end
  end

  def decrement_label(label, lowest, highest)
    label -= 1
    label = highest if label < lowest
    label
  end

  def cup_game(current_cup, lowest, highest, last_move)
    cups = [] of Cup
    cup = current_cup
    loop do
      cups << cup
      cup = cup.right
      break if cup == current_cup
    end
    cups.sort_by! { |cup| cup.label }
    
    move = 0
    loop do
      move += 1
      debug "--move #{move}--"
      #debug "cups: #{print_cups(current_cup, " ")}"
      picked_up = [] of Cup
      picked_up << current_cup.right
      picked_up << picked_up.last.right
      picked_up << picked_up.last.right
      picked_up.each do |cup|
        cup.pick_up
      end
      #debug "pick up: #{picked_up.map(&.label).join(", ")}"
      destination_label = decrement_label(current_cup.label, lowest, highest)
      until picked_up.all? { |cup| cup.label != destination_label }
        destination_label = decrement_label(destination_label, lowest, highest)
      end
      #destination_cup = current_cup
      #until destination_cup.label == destination_label
      #  destination_cup = destination_cup.right
      #end
      destination_cup = cups[destination_label - 1]
      #debug "destination: #{destination_cup.label}"
      until picked_up.empty?
        destination_cup.place_at_right( picked_up.pop )
      end
      current_cup = current_cup.right
      break if move == last_move
      #debug
    end
    until current_cup.label == 1
      current_cup = current_cup.right
    end
    current_cup
  end

  def part1(cup_labels)
    cups = cup_labels.map do |label|
      Cup.new(label)
    end
    prev = cups.last
    cups.each do |cup|
      cup.left = prev
      prev.right = cup
      prev = cup
    end

    cup1 = cup_game(cups.first, 1, 9, 100)

    print_cups cup1, "", skip_first: true
  end

  def print_cups(current_cup, separator = "", skip_first = false)
    cup = current_cup
    cup = cup.right if skip_first
    s = ""
    loop do
      s += separator if s != ""
      s += cup.label.to_s
      cup = cup.right
      break if cup == current_cup
    end
    s
  end

  def part2(cup_labels)
    cups = cup_labels.map do |label|
      Cup.new(label)
    end
    prev = cups.last
    cups.each do |cup|
      cup.left = prev
      prev.right = cup
      prev = cup
    end

    i = 10
    last_cup = cups.last
    debug "building cups..."
    until i == 1_000_001
      new_cup = Cup.new(i)
      last_cup.place_at_right(new_cup)
      last_cup = new_cup
      i += 1
      debug i
    end

    debug "playing game"
    cup1 = cup_game(cups.first, 1, 1_000_000, 10_000_000)

    n1 = cup1.right.label.to_i64
    n2 = cup1.right.right.label.to_i64
    {n1, n2, n1 * n2}
  end
end
