class CalcGameViewController < UIViewController
  
  def loadView
    self.view = UIImageView.alloc.init
  end
  
  def viewDidLoad
    view.image = UIImage.imageNamed('background.jpg')
    view.userInteractionEnabled = true

    @num = make_label
    view.addSubview(@num)
    
    @action = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @action.setTitle('Tap for a new number!', forState:UIControlStateNormal)
    @action.addTarget(self, action:'action_tapped', forControlEvents:UIControlEventTouchUpInside)
    @action.frame = [[10,60], [300,80]]
    view.addSubview(@action)
    
    @numbers = (1..9).to_a
  end

  def action_tapped
    UIView.animateWithDuration(1.0,
                               animations:lambda {
                                   @num.alpha = 0
                                   @num.transform = CGAffineTransformMakeScale(0.1, 0.1)
                               },
                               completion:lambda { |finished|
                                   @num.text = @numbers.sample.to_s
                                   UIView.animateWithDuration(1.0,
                                                    animations:lambda {
                                                        @num.alpha = 1
                                                        @num.transform = CGAffineTransformIdentity
                                                    })
                               })
  end

  def make_label
    margin = 20
    label = UILabel.new
    label.font = UIFont.systemFontOfSize(30)
    label.text = '[no number yet]'
    label.textAlignment = UITextAlignmentCenter
    label.textColor = UIColor.whiteColor
    label.backgroundColor = UIColor.clearColor
    label.frame = [[margin, 240], [view.frame.size.width - margin * 2, 40]]
    label
  end
  
end