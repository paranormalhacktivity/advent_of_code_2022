require "yaml"

class RockPaperScissorGame
  def initialize(input_data_path)
    @input_data_path = input_data_path
  end

  def final_score
    translated_input_data.sum
  end

  def translated_input_data
    input_data.map { |x| 
      RoundScore.new(x.split(" ")).calculate
    }
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
  def initialize(round)
    @player_one = round[0].to_i
    @player_two = round[1].to_i
  end

  def calculate
    if @player_one > @player_two
      @player_two + 0
    elsif @player_two > @player_one
      @player_two + 6
    elsif @player_one == @player_two
      @player_two + 3
    end
  end
end
