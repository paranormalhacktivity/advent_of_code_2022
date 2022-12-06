require "minitest/autorun"
require "minitest/pride"
require "yaml"
require_relative "/advent_of_code_2022/day_2/lib/translator"

class TranslatorTest < Minitest::Test
  def setup
    yaml = YAML.load_file("/advent_of_code_2022/day_2/test/test_config.yml")
    @hash_translator = Translator.new(
      { 
        "A" => 1,
        "Hello, World" => "Hola, Mundo", 
        2 => 10,
        [1, 2] => [1, 10],
        :B => :b
      }
    )
    @yaml_translator = Translator.new(yaml)
  end

  def test_has_a_default_fallback_of_nil_if_translation_does_not_exist
    assert_nil(nil, @hash_translator.translate("Z"))
  end

  def test_accepts_and_returns_the_fallback_value_if_translation_does_not_exist
    assert_equal(0, @hash_translator.translate("Z", fallback: 0))
  end

  def test_translates_single_character_given_a_hash_config
    assert_equal(1, @hash_translator.translate("A"))
  end

  def test_translates_string_given_a_hash_config
    assert_equal("Hola, Mundo", @hash_translator.translate("Hello, World"))
  end

  def test_translates_integer_given_a_hash_config
    assert_equal(10, @hash_translator.translate(2))
  end

  def test_translates_array_given_a_hash_config
    assert_equal([1, 10], @hash_translator.translate([1, 2]))
  end

  def test_translates_symbol_given_a_hash_config
    assert_equal(:b, @hash_translator.translate(:B))
  end

  def test_translates_single_character_given_a_yaml_config
    assert_equal(1, @yaml_translator.translate("A"))
  end

  def test_translates_string_given_a_yaml_config
    assert_equal("Hola, Mundo", @yaml_translator.translate("Hello, World"))
  end

  def test_translates_integer_given_a_yaml_config
    assert_equal(10, @yaml_translator.translate(2))
  end

  def test_translates_array_given_a_yaml_config
    assert_equal([1, 10], @yaml_translator.translate([1, 2]))
  end

  def test_translates_symbol_given_a_yaml_config
    assert_equal(:b, @yaml_translator.translate(:B))
  end
end
