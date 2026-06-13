require 'minitest/autorun'
require_relative '../lib/greed'

class GreedTest < Minitest::Test
  #def test_single_one
  #  assert_equal 100, Greed.score([1, 2, 3, 4, 2, 6])
  #end

  #def test_single_five
  #  assert_equal 50, Greed.score([2, 5, 6])
  #end

  def test_straight
    assert_equal 1200, Greed.score([1, 2, 3, 4, 5, 6])
  end
  def test_six_of_a_kind_5
    assert_equal 4000, Greed.score([5, 5, 5, 5, 5, 5])
  end
end
