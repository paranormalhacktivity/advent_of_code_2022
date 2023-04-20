class MovementCollection
  def self.new(array_of_strings)
    array_of_strings.map do |string|
      Movement.new(extract_integers(string))
    end
  end

  def self.extract_integers(string)
    string.scan(/\d+/).map(&:to_i)
  end
  private_class_method :extract_integers
end
