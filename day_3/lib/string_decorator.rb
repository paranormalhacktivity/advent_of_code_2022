class StringDecorator < SimpleDelegator
  def each_slice(n)
    chars.each_slice(n).map(&:join).to_enum
  end
end
