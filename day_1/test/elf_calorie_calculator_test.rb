require "minitest/autorun"
require "minitest/pride"
require_relative "/advent_of_code_2022/day_1/lib/elf_calorie_calculator"

class ElfCalorieCalculatorTest < Minitest::Test
  def setup
    @calculator = ElfCalorieCalculator.new("#{__dir__}/test_data.txt")
  end

  def test_returns_the_max_integer_when_no_argument_is_supplied
    assert_equal(24000, @calculator.max)
  end

  def test_returns_total_sum_of_top_n_maxes
    assert_equal(45000, @calculator.max(3))
  end
end
