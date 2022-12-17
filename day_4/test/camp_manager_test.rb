require "minitest/autorun"
require "minitest/pride"
require_relative "/advent_of_code_2022/day_4/lib/camp_manager"

class CampManagerTest < Minitest::Test
  def setup
    @test_file_path = "#{__dir__}/test_data.txt"
  end

  def test_can_count_overlapping_assignments
    assert_equal(4, CampManager.new(@test_file_path).count_any_overlapping_assignments)
  end

  def test_can_count_complete_overlapping_assignments
    assert_equal(2, CampManager.new(@test_file_path).count_complete_overlapping_assignments)
  end
end
