class Greed
  attr_reader

  def initialize; end

  def self.is_triples(tallies)
    return false
  end

  def self.take_six_of_a_kind(score, dices)
    return score, dices if dices.length == 0

    tallies = dices.tally
    sixes = tallies.select { |k, v| v == 6 }
    dice = sixes.keys.first

    return score, dices if dice.nil?
    return dice * 100 * 8, [] 
  end

  def self.take_straight(score, dices)
    [1, 2, 3, 4, 5, 6].each do |n|
      return score, dices unless dices.any?(n)
    end
    return score + 1200, []
  end

  def self.score(dices)
    score = 0
    score, dices = take_straight(score, dices) 
    score, dices = take_six_of_a_kind(score, dices) 

    return score
  end
end
