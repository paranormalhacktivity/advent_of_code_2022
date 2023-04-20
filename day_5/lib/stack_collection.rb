class StackCollection < SimpleDelegator
  def self.new(array_of_strings)
    super(array_of_strings.map do |array|
      get_letter(array)
    end.transpose.map { |x| x.reject(&:empty?) })
  end

  def self.get_letter(array)
    array.map { |y| y.delete_if { |x| ["[", "]", " "].include?(x) } }
  end
  private_class_method :get_letter

  def move_boxes(number_of_boxes, from_index, to_index, order: false)
    boxes = self[from_index].shift(number_of_boxes)
    boxes.reverse! if order
    boxes.map { |box| self[to_index].unshift(box) }
  end
end
