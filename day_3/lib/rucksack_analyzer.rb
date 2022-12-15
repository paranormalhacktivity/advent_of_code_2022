require "yaml"
require "delegate"
require "/advent_of_code_2022/day_2/lib/translator"
require "/advent_of_code_2022/day_3/lib/slice_file"
require "/advent_of_code_2022/day_3/lib/string_decorator"

class RucksackAnalyzer
  def initialize(input_data_path, number_of_elves_in_group, compartments: false)
    @input_data_path = input_data_path
    @number_of_elves_in_group = number_of_elves_in_group
    @compartments = compartments
  end

  def sum_of_priorities
    common_item_types.map { |value| translator.translate(value) }.compact.sum
  end

  def common_item_types
    return [] if @number_of_elves_in_group <= 1 && !@compartments

    input_data.map { |slice| intersection(decorate_slice(slice)).join }.uniq.reject(&:empty?)
  end

  private

  def input_data
    SliceFile.readlines(
      @input_data_path, slice_by: @number_of_elves_in_group, chomp: true
    )
  end

  def intersection(slice)
    slice.map { |set| Set.new(set.chars) }.inject(:&)
  end

  def decorate_slice(slice)
    return slice unless @compartments

    slice.map do |string|
      StringDecorator.new(string).each_slice(string_median(string)).to_a
    end.flatten
  end

  def translator
    Translator.new(translation_config)
  end

  def string_median(string)
    string.length / 2
  end

  def translation_config
    YAML.load_file("day_3/config/translations.yml")
  end
end
