require "./src/aoc2020"

ENV["DEBUG"] = "true"

#s = Aoc2020::Ten.new
#s.solution(:example)
#puts s.part2(s.input("example/10b"))
#s.solution(:real)

s = Aoc2020::Seventeen.new
#puts s.part1(s.example_input)
#puts s.part1(s.real_input)
#puts s.part2(s.example_input)
puts s.part2(s.real_input)
