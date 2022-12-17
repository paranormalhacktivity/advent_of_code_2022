require "minitest/autorun"
require "minitest/pride"
require_relative "/advent_of_code_2022/day_4/lib/decorated_csv"
require_relative "/advent_of_code_2022/day_4/lib/array_decorator"

class DecoratedCSVTest < Minitest::Test
  def setup
    @test_file_path = "#{__dir__}/test_data.txt"
  end

  def test_by_default_does_not_decorate_lines
    assert_instance_of(Array, DecoratedCSV.readlines(@test_file_path)[0])
  end

  def test_accepts_decorator_to_decorate_lines_of_file_with
    assert_instance_of(ArrayDecorator, DecoratedCSV.readlines(@test_file_path, decorator: ArrayDecorator)[0])
  end
end
