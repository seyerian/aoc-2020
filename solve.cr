require "./src/aoc2020"

ENV["DEBUG"] = "true"

#s = Aoc2020::Ten.new
#s.solution(:example)
#puts s.part2(s.input("example/10b"))
#s.solution(:real)

s = Aoc2020::TwentyThree.new
#puts s.part1(s.example_input)
#puts s.part1(s.real_input)
#puts s.part2(s.input("example/19b"))
#puts s.part2(s.example_input)
#puts s.part2(s.input("example/22_infinite_loop"))
puts s.part2(s.real_input)
