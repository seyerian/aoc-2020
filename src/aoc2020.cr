def debug(*args)
  if ENV.has_key?("DEBUG") && ENV["DEBUG"]
    puts *args
  end
end

# TODO: Write documentation for `Aoc2020`
module Aoc2020
  VERSION = "0.1.0"

  DAYS = {
    "One" => "01",
    "Two" => "02",
    "Three" => "03",
    "Four" => "04",
    "Five" => "05",
    "Six" => "06",
    "Seven" => "07",
    "Eight" => "08",
    "Nine" => "09",
    "Ten" => "10",
    "Eleven" => "11",
    "Twelve" => "12",
    "Thirteen" => "13",
    "Fourteen" => "14",
    "Fifteen" => "15",
    "Sixteen" => "16",
    "Seventeen" => "17",
    "Eighteen" => "18",
    "Nineteen" => "19",
    "Twenty" => "20",
    "TwentyOne" => "21",
    "TwentyTwo" => "22",
    "TwentyThree" => "23",
    "TwentyFour" => "24",
    "TwentyFive" => "25"
  }

end

require "./solution"
require "./solutions/*"
require "./helpers/*"
