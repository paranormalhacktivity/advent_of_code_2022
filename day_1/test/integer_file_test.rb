require "minitest/autorun"
require "minitest/pride"
require_relative "/advent_of_code_2022/day_1/lib/integer_file"

class IntegerFileTest < Minitest::Test
  def setup
    @test_file_path = "#{__dir__}/test_data.txt"
  end

  def test_returns_an_array
    assert_instance_of(Array, IntegerFile.readlines(@test_file_path))
  end

  def test_has_same_number_of_elements_as_number_of_lines_in_file
    assert_equal(
      File.readlines(@test_file_path).count,
      IntegerFile.readlines(@test_file_path).count
    )
  end

  def test_all_non_empty_lines_are_returned_as_integers_in_array
    assert_equal(
      10,
      IntegerFile.readlines(@test_file_path).count { |x| !x.nil? }
    )
  end

  def test_every_empty_line_is_returned_as_nil_in_array
    assert_equal(5, IntegerFile.readlines(@test_file_path).count(nil))
  end
end
