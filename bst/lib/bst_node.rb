class BSTNode
  attr_reader :value
  attr_accessor :parent, :left, :right

  def initialize(value)
    @value = value
    @parent = nil
    @left = nil
    @right = nil
  end
end
