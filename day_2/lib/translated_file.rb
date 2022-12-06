class TranslatedFile
  def self.readlines(filename, translator)
    File.readlines(filename, chomp: true).map do |line|
      line.split.map do |character|
        translator.translate(character)
      end.join(" ")
    end
  end
end
