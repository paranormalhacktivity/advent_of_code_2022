require "delegate"
require_relative "string_decorator"

class ArrayDecorator < SimpleDelegator
  def [](...)
    StringDecorator.new(super)
  end
end
