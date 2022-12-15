require "minitest/autorun"
require "minitest/pride"
require_relative "/advent_of_code_2022/day_3/lib/slice_file"

class SliceFileTest < Minitest::Test
  def setup
    @test_file_path = "#{__dir__}/test_data.txt"
  end

  def test_has_same_return_as_a_file_being_read_and_then_sliced
    assert_equal(
      File.readlines(@test_file_path, chomp: true).each_slice(3).to_a,
      SliceFile.readlines(@test_file_path, chomp: true, slice_by: 3).to_a
    )
  end
end
