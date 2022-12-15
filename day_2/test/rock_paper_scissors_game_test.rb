require "minitest/autorun"
require "minitest/pride"
require_relative "/advent_of_code_2022/day_2/lib/translator"
require_relative "/advent_of_code_2022/day_2/lib/translated_file"
require_relative "/advent_of_code_2022/day_2/lib/rock_paper_scissors_game"

class RockPaperScissorGameTest < Minitest::Test
  def setup
    @part_one_game_strategy = RockPaperScissorGame.new(
      "/advent_of_code_2022/day_2/test/test_data.txt",
      point_matrix: PART_ONE_MATRIX
    )
    @part_two_game_strategy = RockPaperScissorGame.new(
      "/advent_of_code_2022/day_2/test/test_data.txt",
      point_matrix: PART_TWO_MATRIX
    )
  end

  def test_returns_the_correct_final_score_for_part_one_strategy
    assert_equal(15, @part_one_game_strategy.final_score)
  end

  def test_returns_the_correct_final_score_for_part_two_strategy
    assert_equal(12, @part_two_game_strategy.final_score)
  end

  def test_uses_part_one_matrix_strategy_by_default
    default_test_instance = RockPaperScissorGame.new(
      "/advent_of_code_2022/day_2/test/test_data.txt"
    )
    assert_equal(15, default_test_instance.final_score)
  end
end
