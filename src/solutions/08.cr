require "benchmark"

class Aoc2020::Eight < Aoc2020::Solution
  class BootCodeRunner
    property accumulator
    getter program
    NOP = 0
    ACC = 1
    JMP = 2

    def initialize(@program : Array(Tuple(Int32,Int32)))
      @accumulator = 0
    end

    def run
      hist = [] of Int32
      p = 0
      loop do
        if p >= self.program.size
          return true, self.accumulator
        elsif hist.includes? p
          return false, self.accumulator
        else
          hist << p
        end
        inst, num = self.program[p]
        case inst
        when NOP
          p += 1
        when ACC
          self.accumulator += num
          p += 1
        when JMP
          p += num
        end
      end
    end

    def self.inst_code(inst_s)
      {
        "nop" => NOP,
        "acc" => ACC,
        "jmp" => JMP
      }[inst_s]
    end
  end

  def parse_input(file)
    program = InputParsers.pattern(file, /\A(\w+) ([-+]\d+)\z/) do |m|
      {
        BootCodeRunner.inst_code(m[1]),
        m[2].to_i32
      }
    end
  end

  def part1(input)
    r = BootCodeRunner.new input.compact
    r.run[1]
  end

  def part2(input)
    input = input.clone.compact
    i = 0
    ret = {false, 0}
    until ret[0] == true
      input2 = input.clone
      inst = input2[i]
      case inst[0]
      when BootCodeRunner::NOP
        input2[i] = {BootCodeRunner::JMP, inst[1]}
      when BootCodeRunner::ACC
      when BootCodeRunner::JMP
        input2[i] = {BootCodeRunner::NOP, inst[1]}
      end
      r = BootCodeRunner.new input2
      ret = r.run
      i += 1
    end
    ret[1]
  end
end
