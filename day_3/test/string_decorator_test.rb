require "minitest/autorun"
require "minitest/pride"
require_relative "/advent_of_code_2022/day_3/lib/string_decorator"

class StringDecoratorTest < Minitest::Test
  def setup
    @decorated_string = StringDecorator.new("hello")
  end

  def test_will_slice_a_string
    assert_equal(["he", "ll", "o"], @decorated_string.each_slice(2).to_a)
  end
end
