require "minitest/autorun"
require "minitest/pride"
require_relative "/advent_of_code_2022/day_3/lib/rucksack_analyzer"

class RucksackAnalyzerTest < Minitest::Test
  def setup
    @test_file_path = "#{__dir__}/test_data.txt"
    @test_file_with_common_element_added_to_every_compartment = "#{__dir__}/test_data_2.txt"
  end

  def test_returns_the_sum_of_all_common_item_type_priorities_when_comparing_across_compartments
    assert_equal(
      157,
      RucksackAnalyzer.new(@test_file_path, 1, compartments: true).sum_of_priorities
    )
  end

  def test_returns_the_sum_of_all_common_item_type_priorities_when_comparing_across_multiple_elves
    assert_equal(70, RucksackAnalyzer.new(@test_file_path, 3).sum_of_priorities)
  end

  def test_returns_the_sum_of_all_common_item_type_priorities_when_comparing_across_multiple_elves_and_compartments
    assert_equal(
      27,
      RucksackAnalyzer.new(
        @test_file_with_common_element_added_to_every_compartment, 3, compartments: true
      ).sum_of_priorities
    )
  end

  def test_that_a_single_elf_cannot_be_compared_to_anything_when_compartments_are_false_and_should_return_0
    assert_equal(0, RucksackAnalyzer.new(@test_file_path, 1).sum_of_priorities)
  end

  def test_that_when_all_elves_are_grouped_they_cant_be_compared_to_any_other_group_and_should_return_0
    assert_equal(0, RucksackAnalyzer.new(@test_file_path, 6).sum_of_priorities)
  end

  def test_that_when_no_elves_are_in_a_group_then_nothing_gets_compared_and_should_return_0
    assert_equal(0, RucksackAnalyzer.new(@test_file_path, 0).sum_of_priorities)
  end

  def test_returns_the_common_item_types_when_comparing_across_compartments
    assert_equal(
      ["p", "L", "P", "v", "t", "s"],
      RucksackAnalyzer.new(@test_file_path, 1, compartments: true).common_item_types
    )
  end

  def test_returns_the_common_item_types_when_comparing_across_multiple_elves
    assert_equal(["r", "Z"], RucksackAnalyzer.new(@test_file_path, 3).common_item_types)
  end

  def test_returns_the_common_item_type_priorities_when_comparing_across_multiple_elves_and_compartments
    assert_equal(
      ["A"],
      RucksackAnalyzer.new(
        @test_file_with_common_element_added_to_every_compartment, 3, compartments: true
      ).common_item_types
    )
  end

  def test_that_a_single_elf_cannot_be_compared_to_anything_when_compartments_are_false_and_should_return_no_common_item_types
    assert_empty(RucksackAnalyzer.new(@test_file_path, 1).common_item_types)
  end

  def test_that_when_all_elves_are_grouped_they_cant_be_compared_to_any_other_group_and_should_return_no_common_item_types
    assert_empty(RucksackAnalyzer.new(@test_file_path, 6).common_item_types)
  end

  def test_that_when_no_elves_are_in_a_group_then_nothing_gets_compared_and_returns_no_item_types
    assert_empty(RucksackAnalyzer.new(@test_file_path, 0).common_item_types)
  end
end
