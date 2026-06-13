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

  def test_five_of_a_kind_5_no_signle_one_no_fifty
    assert_equal 1600, Greed.score([4, 4, 4, 4, 4, 2])
  end

  def test_four_of_a_kind_4_no_signle_one_no_fifty
    assert_equal 800, Greed.score([4, 4, 4, 4, 3, 2])
  end

  def test_triple_2_no_signle_one_no_fifty
    assert_equal 200, Greed.score([2, 2, 2, 4, 3, 4])
  end
end
