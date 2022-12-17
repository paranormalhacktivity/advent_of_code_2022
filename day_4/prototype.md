```ruby
require 'csv'
require 'delegate'

class CampManager
  def initialize(input_data_path)
    @input_data_path = input_data_path
  end

  def count_overlapping_assignments
    input_data.map { |line| 
      assignment_overlap?(line)
    }.count(true)
  end

  def input_data
    DecoratedCSV.readlines(@input_data_path, decorator: ArrayDecorator)
  end

  def assignment_overlap?(arr)
    arr[0].to_range.cover?(arr[1].to_range) || 
      arr[1].to_range.cover?(arr[0].to_range)
  end
end

class DecoratedCSV
  def self.readlines(filename, decorator: Array)
    CSV.readlines(filename).map do |line|
      decorator.new(line)
    end
  end
end

class ArrayDecorator < SimpleDelegator
  def [](...)
    StringDecorator.new(super)
  end
end

class StringDecorator < SimpleDelegator
  def to_range
    split("-").then { |element| Range.new(element[0].to_i, element[1].to_i) }
  end
end
```
