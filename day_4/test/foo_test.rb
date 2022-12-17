require "minitest/autorun"
require "minitest/pride"
require_relative "/advent_of_code_2022/day_4/lib/foo"

class FooTest < Minitest::Test
  def setup
    @test_file_path = "#{__dir__}/test_data.txt"
  end

  def test_can_count_overlapping_assignments
    assert_equal(2, CampManager.new(@test_file_path).count_overlapping_assignments)
  end
end
