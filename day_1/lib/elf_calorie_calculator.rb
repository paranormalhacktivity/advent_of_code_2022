require "delegate"
require_relative "array_decorator"
require_relative "integer_file"

class ElfCalorieCalculator
  def initialize(input_file_path)
    @input_file_path = input_file_path
  end

  def max(n = 1)
    total_by_elf.max(n).sum
  end

  private

  def total_by_elf
    input_data_split_by_elf.map(&:sum)
  end

  def input_data_split_by_elf
    input_data.split(nil)
  end

  def input_data
    ArrayDecorator.new(IntegerFile.readlines(@input_file_path))
  end
end
