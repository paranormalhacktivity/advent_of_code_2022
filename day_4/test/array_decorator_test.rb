require "minitest/autorun"
require "minitest/pride"
require_relative "/advent_of_code_2022/day_4/lib/array_decorator"

class ArrayDecoratorTest < Minitest::Test
  def setup
    @array = ["5-6"]
  end

  def test_will_decorate_an_arrays_elements_with_the_string_decorator_class
    assert_instance_of(StringDecorator, ArrayDecorator.new(@array)[0])
  end
end
