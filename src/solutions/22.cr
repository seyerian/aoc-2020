class Aoc2020::TwentyTwo < Aoc2020::Solution
  def initialize
    @game = 0
  end

  def parse_input(file)
    players = InputParsers.groups(file)
    player1 = players[0]
    player1.shift
    player1 = player1.map(&.to_i32)
    player2 = players[1]
    player2.shift
    player2 = player2.map(&.to_i32)
    {player1, player2}
  end

  def part1(input)
    player1 = input[0]
    player2 = input[1]
    i = 0
    until player1.empty? || player2.empty?
      i += 1
      #puts "-- Round #{i} --"
      #puts "Player 1's deck: #{player1.join(", ")}"
      #puts "Player 2's deck: #{player2.join(", ")}"
      p1_card = player1.shift
      p2_card = player2.shift
      #puts "Player 1 plays: #{p1_card}"
      #puts "Player 2 plays: #{p2_card}"
      if p1_card > p2_card
        player1.concat [p1_card, p2_card]
        #puts "Player 1 wins the round!"
      elsif p2_card > p1_card
        player2.concat [p2_card, p1_card]
        #puts "Player 2 wins the round!"
      else
        raise "cards same"
      end
    end
    #puts "== Post-game results =="
    #puts "Player 1's deck: #{player1.join(", ")}"
    #puts "Player 2's deck: #{player2.join(", ")}"
    winning_deck = player1 + player2
    score = 0
    winning_deck.reverse.each.with_index do |card, i|
      score += card * (i+1)
    end
    #puts "Score: #{score}"
    score
  end

  def part2(input)
    @game = 0
    recursive_combat(input[0], input[1])
  end

  def recursive_combat(player1, player2)
    #puts @game
    @game += 1
    game = @game.clone
    
    states = [] of Tuple(UInt64, UInt64)
    #puts "== Game #{game} =="
    i = 0

    winner = 0
    over = false
    until player1.empty? || player2.empty? || over
      if states.any?{|s| s == {player1.hash, player2.hash}}
        #puts "previous state match"
        winner = 1
        over = true
        break
      end
      states.push({player1.hash, player2.hash})
      i += 1
      #puts "-- Round #{i} --"
      #puts "Player 1's deck: #{player1.join(", ")}"
      #puts "Player 2's deck: #{player2.join(", ")}"
      p1_card = player1.shift
      p2_card = player2.shift
      #puts "Player 1 plays: #{p1_card}"
      #puts "Player 2 plays: #{p2_card}"
      winner =
        if player1.size >= p1_card && player2.size >= p2_card
          #puts "Playing a sub-game to determine the winner..."
          subgame_p1 = player1.first(p1_card)
          subgame_p2 = player2.first(p2_card)
          w = recursive_combat(subgame_p1, subgame_p2)
          #puts "...anyway, back to game #{game}."
          w
        else
          p1_card > p2_card ? 1 : 2
        end
      if winner == 1
        player1.concat [p1_card, p2_card]
        #puts "Player 1 wins round #{i} of game #{game}!"
      elsif winner == 2
        player2.concat [p2_card, p1_card]
        #puts "Player 2 wins round #{i} of game #{game}!"
      else
        raise "cards same"
      end
    end

    if game == 1
      #puts "== Post-game results =="
      #puts "Player 1's deck: #{player1.join(", ")}"
      #puts "Player 2's deck: #{player2.join(", ")}"
      winning_deck = winner == 1 ? player1 : player2
      score = 0
      winning_deck.reverse.each.with_index do |card, i|
        score += card * (i+1)
      end
      #puts "Score: #{score}"
      score
    else
      #puts "The winner of game #{game} is player #{winner}!"
      return winner
    end
  end
end
