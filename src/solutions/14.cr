class Aoc2020::Fourteen < Aoc2020::Solution
  def parse_input(file)
    InputParsers.pattern(file, /\A(\w+)(?:\[(\d+)\])? = (.*)\z/) do |m|
      {
        m[1], # instruction
        m[2]? ? m[3].to_i64 : m[3], # value
        m[2]? ? m[2].to_i64 : nil # address (for inst=mem)
      }
    end
  end

  def apply_bitmask(num, bitmask)
    bits = num.to_i64.to_s(2).reverse.chars
    bm_chars = bitmask.to_s.clone.reverse.chars
    bm_chars.each_with_index do |c, i|
      if bits[i]?.nil?
        bits.push '0'
      end
      next if c == 'X'
      bits[i] = c
    end
    bits.reverse.join.to_i64(2)
  end

  def part1(instructions)
    highest_address = instructions.reduce(0) do |h, inst|
      next h if inst.nil?
      addr = inst[2]
      next h if addr.nil?
      addr > h ? addr : h
    end

    bitmask = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
    memory = Array(Int64).new(highest_address + 1, 0_i64)

    instructions.each do |inst|
      next if inst.nil?
      case inst[0]
      when "mask"
        bitmask = inst[1]
      when "mem"
        addr = inst[2]
        next if addr.nil?
        memory[addr] = apply_bitmask(inst[1], bitmask)
      end
    end
    memory.sum
  end

  def part2(instructions)
    highest_address = instructions.reduce(0) do |h, inst|
      next h if inst.nil?
      addr = inst[2]
      next h if addr.nil?
      addr > h ? addr : h
    end

    bitmask = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
    memory = Hash(Int64, Int64).new

    instructions.each do |inst|
      next if inst.nil?
      case inst[0]
      when "mask"
        bitmask = inst[1]
      when "mem"
        addr = inst[2]
        next if addr.nil?
        apply_bitmask_v2(addr, bitmask).each do |a|
          memory[a] = inst[1].to_i64
        end
      end
    end

    memory.values.sum
  end

  def apply_bitmask_v2(address, bitmask)
    addr = address.to_i64.to_s(2)
    until addr.size == bitmask.to_s.size
      addr = '0' + addr
    end
    addr_chars = addr.reverse.chars
    bm_chars = bitmask.to_s.clone.reverse.chars
    bm_chars.each_with_index do |c, i|
      next if c == '0'
      addr_chars[i] = c
    end
    addresses = [ addr_chars ]
    addr_chars.each_with_index do |c, i|
      next unless c == 'X'
      addrs_clone = addresses.clone
      addresses.each_with_index do |a, j|
        a[i] = '0'
      end
      addrs_clone.each_with_index do |a, j|
        a[i] = '1'
      end
      addresses.concat addrs_clone
    end
    addresses.map do |a|
      a.reverse.join.to_i64(2)
    end
  end
end
