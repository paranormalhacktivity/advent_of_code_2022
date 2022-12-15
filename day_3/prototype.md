```ruby
require "yaml"
require "delegate"
require "/advent_of_code_2022/day_2/lib/translator"

class RucksackPrioritizer
  def initialize(input_data_path)
    @input_data_path = input_data_path
  end

  def find_common_item_type_and_priority_sum
    input_data.map do |line| 
      set_1, set_2 = line.each_slice(2).map { |set| Set.new(set) }
      intersection = set_1 & set_2
      intersection.map do |value| 
        translator.translate(value) 
      end
    end.flatten.sum
  end

  def input_data
    @input_data = DecoratedFile.readlines(
      @input_data_path, 
      decorator: decorator, 
      chomp: true
    )
  end

  def decorator
    StringDecorator
  end

  def translator
    Translator.new(translation_config)
  end

  def translation_config
    YAML.load_file("day_3/config/translations.yml")
  end
end

class StringDecorator < SimpleDelegator
  def each_slice(n)
    chars.each_slice(size / n)
  end
end

class DecoratedFile
  def self.readlines(filename, decorator: String, chomp: false)
    File.readlines(filename, chomp: chomp).map do |line|
      decorator.new(line)
    end
  end
end
```
