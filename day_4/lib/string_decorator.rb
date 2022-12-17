require "delegate"

class StringDecorator < SimpleDelegator
  def to_range
    split("-").then { |element| Range.new(element[0].to_i, element[1].to_i) }
  end
end
