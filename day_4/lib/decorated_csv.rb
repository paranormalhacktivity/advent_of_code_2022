require "csv"

class DecoratedCSV
  def self.readlines(filename, decorator: Array)
    CSV.readlines(filename).map do |line|
      decorator.new(line)
    end
  end
end
