describe "Equation" do
  before do
    @equation = Equation.new(UIView.alloc.init, :+, [3, 5])
  end

  it "creates an equation as expected" do
    @equation.operands.size.should == 2
    @equation.operands.first.should == 3
    @equation.operands.last.should == 5
    @equation.operator.should == :+
    @equation.result.should == 8
    @equation.label.text.should == '3 + 5 = ?'
  end
end
