class Equation

  OPERATIONS = [:+, :-, :/, :*]
  MAX_OPERATOR = 10

  attr_reader :result, :label, :operator, :operands, :label

  def initialize(parent_view, operator = :+, operands = [rand(MAX_OPERATOR) + 1, rand(MAX_OPERATOR) + 1])
    @view, @operator, @operands  = parent_view, operator, operands
    @result = @operands[0].send(operator, @operands[1])
    @label = make_equation_label
  end

  private

    def make_equation_label(op = @operator, ops = @operands, res = '?')
      margin = 20
      label = UILabel.new
      label.font = UIFont.systemFontOfSize(30)
      label.text = "#{ops[0]} #{op} #{ops[1]} = #{res}"
      label.textAlignment = UITextAlignmentCenter
      label.textColor = UIColor.whiteColor
      label.backgroundColor = UIColor.clearColor
      label.frame = [[margin, margin * 3], [@view.frame.size.width - margin * 2, 40]]
      label
    end

end