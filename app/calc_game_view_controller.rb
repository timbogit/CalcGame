class CalcGameViewController < UIViewController
  
  def loadView
    self.view = UIImageView.alloc.init
  end
  
  def viewDidLoad
    view.image = UIImage.imageNamed('background.jpg')
    
    @label = make_label
    view.addSubview(@label)  
    
    view.userInteractionEnabled = true    
    tap = UITapGestureRecognizer.alloc.initWithTarget(self, action:'show_answer')
    view.addGestureRecognizer(tap)
    
    @numbers = [1,2,3,4,5,6,7,8]
  end
  
  def show_answer
    UIView.animateWithDuration(1.0,
                               animations:lambda {
                                   @label.alpha = 0
                                   @label.transform = CGAffineTransformMakeScale(0.1, 0.1)
                               },
                               completion:lambda { |finished|
                                   @label.text = @numbers.sample.to_s
                                   UIView.animateWithDuration(1.0,
                                                    animations:lambda {
                                                        @label.alpha = 1
                                                        @label.transform = CGAffineTransformIdentity
                                                    })
                               })
  end

  def make_label
    label = UILabel.alloc.initWithFrame([[10,60], [300,80]])
    label.backgroundColor = UIColor.lightGrayColor
    label.text = "Tap for a new number!"
    label.font = UIFont.boldSystemFontOfSize(34)
    label.textColor = UIColor.darkGrayColor
    label.textAlignment = UITextAlignmentCenter
    label
  end
  
end