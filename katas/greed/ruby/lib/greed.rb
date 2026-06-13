class Greed
  attr_reader

  TRIPLE_DICE = {
    1 => 1000, 
    2 => 200, 
    3 => 300, 
    4 => 400, 
    5 => 500,
    6 => 600
  }

  MULTIPLIERS_KIND = {
    0 => 0,
    1 => 0,
    2 => 0,
    3 => 1,
    4 => 2,
    5 => 4,
    6 => 8,
  }

  def initialize; end

  def self.is_triples(tallies)
    return false
  end

  def self.take_straight(score, dices)
    return score, dices if dices.length == 0

    [1, 2, 3, 4, 5, 6].each do |n|
      return score, dices unless dices.any?(n)
    end
    return score + 1200, []
  end

  def self.get_kind_score(dice, kind)
    base_score = TRIPLE_DICE[dice]
    multiplier = MULTIPLIERS_KIND[kind]

    base_score * multiplier
  end

  def self.take_x_of_a_kind(score, dices)
    tallies = dices.tally
    tallies.each do |dice, kind|
      score += get_kind_score(dice, kind)
      dices = dices.reject { |d| d == dice } if kind >= 3
    end
    return score, dices
  end

  def self.score(dices)
    score = 0
    tallies = dices.tally
    score, dices = take_straight(score, dices) 
    score, dices = take_x_of_a_kind(score, dices) 

    return score
  end
end
