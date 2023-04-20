require "minitest/autorun"
require "minitest/pride"
require_relative "/advent_of_code_2022/day_5/lib/box_stacker"

class BoxStackerTest < Minitest::Test
  def setup
    @test_file_path = "#{__dir__}/test_data.txt"
  end

  def test_blah
    assert_equal("CMZ", BoxStacker.new(@test_file_path).collect_top_of_stacks)
  end

  def test_order
    assert_equal("MCD", BoxStacker.new(@test_file_path, order: true).collect_top_of_stacks)
  end
end
