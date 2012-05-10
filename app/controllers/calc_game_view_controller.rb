class CalcGameViewController < UIViewController

  BUTTONS = 9

  def loadView
    self.view = UIImageView.alloc.init
  end

  def viewDidLoad
    view.image = UIImage.imageNamed('background.jpg')
    view.userInteractionEnabled = true

    @equation = make_equation_label
    view.addSubview(@equation)

    @number_buttons = []
    (0...BUTTONS).each do |pos|
      number_button = make_button(pos, withValue: (rand(BUTTONS) + 1))
      @number_buttons <<  number_button
      view.addSubview(number_button)
    end

  end

  def make_equation_label
    margin = 20
    label = UILabel.new
    label.font = UIFont.systemFontOfSize(30)
    label.text = '9 - 8 = ?'
    label.textAlignment = UITextAlignmentCenter
    label.textColor = UIColor.whiteColor
    label.backgroundColor = UIColor.clearColor
    label.frame = [[margin, margin * 3], [view.frame.size.width - margin * 2, 40]]
    label
  end

  def make_button(pos, withValue:val)
    margin = 10
    width = height = (view.frame.size.width - margin * 4) / 3
    top_y = 150
    button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    button.setTitle(val.to_s, forState:UIControlStateNormal)
    button.addTarget(self, action:"action_tapped:", forControlEvents:UIControlEventTouchUpInside)
    button.frame = [[(pos % 3) * (margin + width) + margin, top_y + ((pos / 3) * (margin + height)) ], [width, height]]
    button
  end

  def action_tapped(sender)
    UIView.animateWithDuration(1.0,
                               animations:lambda {
                                   @equation.alpha = 0
                                   @equation.transform = CGAffineTransformMakeScale(0.1, 0.1)
                               },
                               completion:lambda { |finished|
                                   @equation.text = sender.currentTitle
                                   UIView.animateWithDuration(1.0,
                                                    animations:lambda {
                                                        @equation.alpha = 1
                                                        @equation.transform = CGAffineTransformIdentity
                                                    })
                               })
  end

end
