require "minitest/autorun"
require "minitest/pride"
require_relative "/advent_of_code_2022/day_2/lib/translator"
require_relative "/advent_of_code_2022/day_2/lib/translated_file"
require_relative "/advent_of_code_2022/day_2/lib/rock_paper_scissors_game"


class RockPaperScissorGameTest < Minitest::Test
  def setup
    @game = RockPaperScissorGame.new("/advent_of_code_2022/day_2/test/test_data.txt")
  end

  def test_returns_the_correct_final_score
    assert_equal(15, @game.final_score)
  end
end
