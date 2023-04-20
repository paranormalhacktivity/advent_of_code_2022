require "minitest/autorun"
require "minitest/pride"
require_relative "/advent_of_code_2022/day_5/lib/movement"

class MovementTest < Minitest::Test
  def setup
    @number_of_boxes = 1
    @from_stack_number = 2
    @to_stack_number = 1
    @movement = Movement.new([@number_of_boxes, @from_stack_number, @to_stack_number])
  end

  def test_should_return_the_number_of_boxes_specified_for_movement
    assert_equal(@number_of_boxes, @movement.number_of_boxes)
  end

  def test_should_return_the_index_of_the_stack_that_boxes_need_to_move_to
    assert_equal(@to_stack_number - 1, @movement.to_index)
  end

  def test_should_return_the_index_of_the_stack_that_boxes_need_to_move_from
    assert_equal(@from_stack_number - 1, @movement.from_index)
  end
end

