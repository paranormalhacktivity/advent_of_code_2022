class Translator
  def initialize(config)
    @config = config
  end

  def translate(value, fallback: nil)
    @config.fetch(value, fallback)
  end
end
