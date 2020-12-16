class Aoc2020::Sixteen < Aoc2020::Solution
  def parse_input(file)
    notes = InputParsers.groups(file)
    rules = notes[0]
    rules = rules.reduce(Hash(String, Array(Range(Int32, Int32))).new) do |hash, rule|
      m = rule.match(/\A([\w ]+): (\d+)-(\d+) or (\d+)-(\d+)\z/)
      next hash if m.nil?
      hash[m[1]] = [
        (m[2].to_i32..m[3].to_i32),
        (m[4].to_i32..m[5].to_i32)
      ]
      hash
    end
    my_ticket = notes[1][1].split(',').map(&.to_i32)
    nearby_tickets = notes[2][1..-1].map do |ticket|
      ticket.split(',').map(&.to_i32)
    end
    return rules, my_ticket, nearby_tickets
  end

  def part1(notes)
    rules = notes[0]
    my_ticket = notes[1]
    nearby_tickets = notes[2]
    invalid_values = [] of Int32
    nearby_tickets.each do |ticket|
      ticket.each do |value|
        invalid = rules.all? do |rule_name, rule_ranges|
          rule_ranges.all? do |rule_range|
            !rule_range.includes?(value)
          end
        end
        if invalid
          invalid_values << value
        end
      end
    end
    invalid_values.sum
  end

  def part2(notes)
    rules = notes[0]
    my_ticket = notes[1]
    nearby_tickets = notes[2]
    invalid_values = [] of Int32
    # ticket is invalid if
    debug "Removing invalid nearby tickets"
    nearby_tickets.reject! do |ticket|
      # there is any value
      ticket.any? do |value|
        # where all rule
        rules.all? do |rule_name, rule_ranges|
          # ranges
          rule_ranges.all? do |rule_range|
            # do not include the value
            !rule_range.includes?(value)
          end
        end
      end
    end
    debug "Constructing possible rule indexes"
    possible_rule_indexes = Hash(String, Array(Int32)).new
    last_index = my_ticket.size - 1
    rules.each do |name, ranges|
      index = (0..last_index).to_a.select do |i|
        nearby_tickets.all? do |nt|
          ranges.any? do |range|
            range.includes?(nt[i])
          end
        end
      end
      index ||= [-1]
      possible_rule_indexes[name] = index
    end
    debug "Constructing rule indexes"
    rule_indexes = Hash(String, Int32).new
    until possible_rule_indexes.empty?
      possible_rule_indexes.each do |name, indexes|
        if indexes.size == 1
          rule_indexes[name] = indexes[0]
        end
      end
      rule_indexes.each do |name, index|
        possible_rule_indexes.delete(name)
        possible_rule_indexes.each do |name, indexes|
          indexes.delete(index)
        end
      end
    end
    departure_rules = rule_indexes.select do |name, index|
      name.match(/\Adeparture/)
    end
    departure_rules.reduce(1_i64) do |product, (name, index)|
      product * my_ticket[index]
    end
  end
end
