require 'minitest/autorun'
require_relative '../lib/greed'

class GreedTest < Minitest::Test
  def test_0_score
    assert_equal 0, Greed.score([3, 6, 3, 4])
  end

  def test_0_score_two_ones
    assert_equal 0, Greed.score([1, 1, 3, 4])
  end

  def test_almost_three_pairs
    assert_equal 0, Greed.score([1, 1, 2, 2, 3, 4])
  end

  def test_single_one
    assert_equal 100, Greed.score([1, 2, 3, 4, 2, 6])
  end

  def test_single_five
    assert_equal 50, Greed.score([2, 5, 6])
  end

  def test_straight
    assert_equal 1200, Greed.score([1, 2, 3, 4, 5, 6])
  end

  def test_six_of_a_kind_5
    assert_equal 4000, Greed.score([5, 5, 5, 5, 5, 5])
  end

  def test_five_of_a_kind_5_no_single_one_no_fifty
    assert_equal 1600, Greed.score([4, 4, 4, 4, 4, 2])
  end

  def test_four_of_a_kind_4_no_single_one_no_fifty
    assert_equal 800, Greed.score([4, 4, 4, 4, 3, 2])
  end

  def test_triple_2_no_single_one_no_fifty
    assert_equal 200, Greed.score([2, 2, 2, 4, 3, 4])
  end

  def test_triple_1_no_single_one_no_fifty
    assert_equal 1000, Greed.score([1, 2, 1, 4, 3, 1])
  end

  def test_four_of_kind_1_no_single_one_no_fifty
    assert_equal 2000, Greed.score([1, 1, 1, 4, 3, 1])
  end

  def test_triple_1_no_single_one_no_fifty_4_dices
    assert_equal 1000, Greed.score([1, 2, 1, 1])
  end

  def test_three_pairs
    assert_equal 800, Greed.score([1, 2, 1, 2, 3, 3])
  end

  def test_triples_and_one_no_fifty
    assert_equal 200 + 100, Greed.score([2, 2, 2, 1, 3, 4])
  end

  def test_triples_and_one_and_one_fifty
    assert_equal 200 + 100 + 50, Greed.score([2, 2, 2, 1, 3, 5])
  end

  def test_two_triples
    assert_equal 200 + 300, Greed.score([2, 2, 2, 3, 3, 3])
  end

  def test_4_dices_one_fifty
    assert_equal 100 + 50, Greed.score([1, 2, 5, 4])
  end

  def test_4_dices_triple_and_fifty
    assert_equal 300 + 50, Greed.score([3, 3, 3, 5])
  end
end
