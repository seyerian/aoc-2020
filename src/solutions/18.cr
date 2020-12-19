class Aoc2020::Eighteen < Aoc2020::Solution
  def parse_input(file)
    File.read_lines(file)
  end

  def eval_expr_add_prec(x : String)
    x = x.clone
    while m = x.match(/(\([\d \*\+]+\))/)
      inner = m[1][1..-2]
      x = x.sub(m[1], eval_expr_add_prec(inner))
    end
    while m = x.match(/(\d+) \+ (\d+)/)
      n1 = m[1].to_i64
      n2 = m[2].to_i64
      v = n1 + n2
      x = x.sub(m[0], v.to_s)
    end
    while m = x.match(/(\d+) \* (\d+)/)
      n1 = m[1].to_i64
      n2 = m[2].to_i64
      v = n1 * n2
      x = x.sub(m[0], v.to_s)
    end
    x.to_i64
  end

  def eval_expr_same_prec(x : String)
    x = x.clone
    while m = x.match(/(\([\d \*\+]+\))/)
      inner = m[1][1..-2]
      x = x.sub(m[1], eval_expr_same_prec(inner))
    end
    while m = x.match(/\A(\d+) ([\*\+]) (\d+)/)
      n1 = m[1].to_i64
      op = m[2][0]
      n2 = m[3].to_i64
      v = 
        case op
        when '*'
          n1 * n2
        when '+'
          n1 + n2
        end
      x = x.sub(m[0], v.to_s)
    end
    x.to_i64
  end

  def part1(expressions)
    expressions.sum do |x|
      eval_expr_same_prec(x)
    end
  end

  def part2(expressions)
    expressions.sum do |x|
      eval_expr_add_prec(x)
    end
  end
end
