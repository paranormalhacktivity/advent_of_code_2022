require "minitest/autorun"
require "minitest/pride"
require_relative "/advent_of_code_2022/day_1/lib/array_decorator"

class ArrayDecoratorTest < Minitest::Test
  def setup
    @array = ArrayDecorator.new([1, 2, "3", nil, 4, 5])
  end

  def test_should_inherit_from_simple_delegator_class
    assert_equal(SimpleDelegator, ArrayDecorator.superclass)
  end

  def test_should_split_an_array_into_subarrays_based_on_given_delimiter
    assert_equal([[1, 2], [nil, 4, 5]], @array.split("3"))
    assert_equal([[1, 2, "3"], [4, 5]], @array.split(nil))
    assert_equal([[1], ["3", nil, 4, 5]], @array.split(2))
    assert_equal([[1, 2, "3", nil, 4], []], @array.split(1))
  end

  def test_will_split_on_every_instance_of_the_given_delimiter
    assert_equal(
      [[1, 2], [4], [5]],
      ArrayDecorator.new([1, 2, 3, 4, 3, 5]).split(3)
    )
  end
end
