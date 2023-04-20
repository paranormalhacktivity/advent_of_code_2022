require "delegate"

class Movement < SimpleDelegator
  def number_of_boxes
    self[0]
  end

  def to_index
    self[2] - 1
  end

  def from_index
    self[1] - 1
  end
end
