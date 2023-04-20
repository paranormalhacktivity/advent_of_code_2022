require "csv"
require "/advent_of_code_2022/day_5/lib/movement"
require "/advent_of_code_2022/day_5/lib/movement_collection"
require "/advent_of_code_2022/day_5/lib/stack_collection"

class BoxStacker
  def initialize(input_data_path, order: false)
    @input_data_path = input_data_path
    @order = order
  end

  def collect_top_of_stacks
    execute_moves.map(&:shift).join
  end

  def execute_moves
    stacks.tap do |s|
      movements.each do |movement|
        s.move_boxes(
          movement.number_of_boxes, 
          movement.from_index, 
          movement.to_index, 
          order: @order
        )
      end
    end
  end

  private

  def stacks
    @stacks ||= StackCollection.new(lines_containing_stacks)
  end

  def movements
    @movements ||= MovementCollection.new(lines_containing_movements)
  end

  def lines_containing_stacks
    input_data.take_while { |line| !line.strip.empty? }.tap(&:pop).map do |line|
      line.chars.each_slice(4).to_a
    end
  end

  def lines_containing_movements
    input_data.drop_while { |line| !line.strip.empty? }.tap(&:shift)
  end

  def input_data
    @input_data ||= File.readlines(@input_data_path, chomp: true)
  end
end
