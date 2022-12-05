class IntegerFile
  def self.readlines(filename)
    File.readlines(filename, chomp: true).map do |line|
      line.empty? ? nil : line.to_i
    end
  end
end
