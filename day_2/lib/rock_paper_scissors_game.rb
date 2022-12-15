require "yaml"
require_relative "translator"
require_relative "translated_file"

PART_ONE_MATRIX = [
  [4, 8, 3],
  [1, 5, 9],
  [7, 2, 6]
]
PART_TWO_MATRIX = [
  [3, 4, 8],
  [1, 5, 9],
  [2, 6, 7]
]

class RockPaperScissorGame
  def initialize(input_data_path, point_matrix: PART_ONE_MATRIX)
    @input_data_path = input_data_path
    @point_matrix = point_matrix
  end

  def final_score
    translated_input_data.sum
  end

  def translated_input_data
    input_data.map do |line|
      x, y = line.split(" ").map { |i| i.to_i - 1 }
      @point_matrix[x][y]
    end
  end

  def input_data
    TranslatedFile.readlines(@input_data_path, translator)
  end

  def translator
    Translator.new(translation_config)
  end

  def translation_config
    YAML.load_file("day_2/config/translations.yml")
  end
end
