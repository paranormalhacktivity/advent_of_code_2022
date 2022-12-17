require "minitest/autorun"
require "minitest/pride"
require_relative "/advent_of_code_2022/day_4/lib/string_decorator"

class StringDecoratorTest < Minitest::Test
  def setup
    @string = "5-6"
  end

  def test_takes_an_array_string_and_converts_it_to_a_range_instance
    assert_instance_of(Range, StringDecorator.new(@string).to_range)
  end

  def test_the_converted_string_is_the_correct_range
    assert_equal(Range.new(5, 6), StringDecorator.new(@string).to_range)
  end
end
