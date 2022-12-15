require "minitest/autorun"
require "minitest/pride"
require_relative "/advent_of_code_2022/day_2/lib/translator"
require_relative "/advent_of_code_2022/day_2/lib/translated_file"

class TranslatedFileTest < Minitest::Test
  def setup
    config = {"A" => 1, "Y" => 2}
    @test_file_path = "#{__dir__}/test_data.txt"
    @translator = Translator.new(config)
  end

  def test_returns_readlines_array_with_values_translated
    assert_equal("1 2", TranslatedFile.readlines(@test_file_path, @translator).first)
  end
end
