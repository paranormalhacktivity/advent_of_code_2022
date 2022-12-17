require_relative "array_decorator"
require_relative "decorated_csv"
require_relative "string_decorator"

class CampManager
  def initialize(input_data_path)
    @input_data_path = input_data_path
  end

  def count_any_overlapping_assignments
    input_data.map { |line| assignment_overlap?(line) }.count(true)
  end

  def count_complete_overlapping_assignments
    input_data.map { |line| complete_assignment_overlap?(line) }.count(true)
  end

  def input_data
    DecoratedCSV.readlines(@input_data_path, decorator: ArrayDecorator)
  end

  def assignment_overlap?(arr)
    !arr[0].to_range.to_a.intersection(arr[1].to_range.to_a).empty?
  end

  def complete_assignment_overlap?(arr)
    arr[0].to_range.cover?(arr[1].to_range) ||
      arr[1].to_range.cover?(arr[0].to_range)
  end
end
