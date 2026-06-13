class Greed
  attr_reader

  def initialize; end

  def self.is_triples(tallies)
    return false
  end

  def self.is_straight(dices)
    [1, 2, 3, 4, 5, 6].each do |n|
      return false unless dices.any?(n)
    end
    return true
  end

  def self.score(dices)
    tallies = dices.tally
    score = 0
    if is_straight(dices)
      return 1200
    end
    if tallies[1] == 1
      score += 100
    end
    if tallies[5] == 1
      score += 50
    end

    return score
  end
end
