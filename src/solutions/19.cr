class Aoc2020::Nineteen < Aoc2020::Solution
  def parse_input(file)
    groups = InputParsers.groups(file)
    rules = Hash(Int32, String).new
    groups[0].each do |line|
      m = line.match /\A(\d+): "?([ |\d\w]+)"?\z/
      next if m.nil?
      rules[m[1].to_i32] = m[2]
    end
    messages = groups[1]
    return {rules, messages}
  end

  def regexify(rule_num, rule, rules, parent_rule_num : Int32, loop_depth = 0)
    if rule.match /\A[[:alpha:]]+\z/
      rule
    elsif rule.match /\|/
      ors = rule.split(" | ").map do |r|
        regexify(rule_num, r, rules, rule_num, loop_depth).as(String)
      end
      "(?:#{ors.join('|')})"
    elsif rule.match /\ /
      rule.split(' ').map do |subrule|
        regexify(rule_num, subrule, rules, rule_num, loop_depth).as(String)
      end.join
    elsif m = rule.match /\A(\d+)\z/
      if loop_depth < 6
        nested_rule_num = m[1].to_i32
        regexify(
          nested_rule_num,
          rules[nested_rule_num],
          rules,
          rule_num,
          nested_rule_num==rule_num ? loop_depth + 1 : 0
        )
      else
        ""
      end
    else
      raise "error"
    end
  end

  def rules_regex(rules)
    Regex.new "\\A" + regexify(0, rules[0], rules, -1) + "\\z"
  end

  def part1(input)
    rules = input[0]
    messages = input[1]
    regex = rules_regex(rules)
    messages.count do |msg|
      msg.match regex
    end
  end

  def part2(input)
    rules = input[0]
    rules[8] = "42 | 42 8"
    rules[11] = "42 31 | 42 11 31"
    messages = input[1]
    regex = rules_regex(rules)
    messages.count do |msg|
      msg.match regex
    end
  end
end
