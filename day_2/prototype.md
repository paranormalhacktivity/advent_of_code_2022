```ruby
require "yaml"

class RockPaperScissorGame
  def initialize(input_data_path)
    @input_data_path = input_data_path
  end

  def final_score
    translated_input_data.sum
  end

  def translated_input_data
    input_data.map do |x| 
      RoundScore.new(x.split(" ")).calculate
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

class Translator
  def initialize(config)
    @config = config
  end

  def translate(value, fallback: nil)
    @config.fetch(value, fallback)
  end
end

class TranslatedFile
  def self.readlines(filename, translator)
    File.readlines(filename, chomp: true).map do |line|
      line.split.map do |character|
        translator.translate(character)
      end.join(" ").strip
    end
  end
end

class RoundScore
  POINT_MATRIX = [
    [4, 8, 3],
    [1, 5, 9],
    [7, 2, 6]
  ]

  def initialize(round)
    @player_one = round[0].to_i
    @player_two = round[1].to_i
  end

  def calculate
    POINT_MATRIX[@player_one - 1][@player_two - 1]
  end
end
```

