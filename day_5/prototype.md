```ruby
require "csv"
require 'delegate'

class Foo
  def initialize(input_data_path)
    @input_data_path = input_data_path
  end

  def collect_top_of_stacks
    execute_moves.map(&:shift).join
  end

  def execute_moves
    stacks.tap do |s|
      movements.each do |movement|
        s.move_boxes(movement.box_count, movement.from, movement.to)
      end
    end
  end

  def stacks
    @stacks ||= StackCollection.new(lines_containing_stacks)
  end

  def movements
    @movements ||= MovementCollection.new(lines_containing_movements)
  end

  def lines_containing_stacks
    input_data.take_while { |line| !line.strip.empty? }.tap(&:pop).map do |x|
      x.split("").each_slice(4).to_a
    end
  end

  def lines_containing_movements
    input_data.drop_while { |line| !line.strip.empty? }.tap(&:shift)
  end

  def input_data
    @input_data ||= File.readlines(@input_data_path, chomp: true)
  end
end

class StringDecorator < SimpleDelegator
  def each_slice(n)
    chars.each_slice(n).map(&:join).to_enum
  end
end

class StackCollection < SimpleDelegator
  def self.new(array_of_strings)
    super(array_of_strings.map do |array| 
      get_letter(array)
    end.transpose.map { |x| x.reject(&:empty?) })
  end

  def move_boxes(number_of_boxes, from_index, to_index)
    self[from_index].shift(number_of_boxes).map { |box| self[to_index].unshift(box) }
  end

  def self.get_letter(array)
    array.map{ |y| y.delete_if { |x| ["[", "]", " "].include?(x) } }
  end
  private_class_method :get_letter
end

class Stack < SimpleDelegator
end

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

class Movement < SimpleDelegator
  def box_count
    self[0]
  end

  def to
    self[2] - 1
  end

  def from
    self[1] - 1
  end
end
```
