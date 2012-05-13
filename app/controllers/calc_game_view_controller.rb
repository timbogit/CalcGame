class CalcGameViewController < UIViewController

  BUTTONS = 9

  attr_accessor :equation, :number_buttons

  def loadView
    self.view = UIImageView.alloc.init
  end

  def viewDidLoad
    view.image = UIImage.imageNamed('background.jpg')
    view.userInteractionEnabled = true
    load_sound_effects

    add_equation_and_number_buttons

  end

  def equation
    @equation ||= Equation.new(view)
  end

  def number_buttons
    @number_buttons ||= []
  end

  def add_equation_and_number_buttons
    view.addSubview(equation.label)

    make_random_buttons.each { |button|
      view.addSubview(button)
    }
  end

  def make_random_buttons
    winner_pos = rand(BUTTONS)
    (0...BUTTONS).each do |pos|
      button =  (pos == winner_pos) ? make_button(pos, withValue: equation.result, forSuccess: true) : make_button(pos, withValue: (rand(BUTTONS) + 1), forSuccess: false)
      puts "YAY: #{button.currentTitle}"
      number_buttons << button
    end
    number_buttons
  end

  def remove_equation_and_number_buttons
    remove_equation
    remove_number_bottons
  end

  def remove_equation
    @equation.label.removeFromSuperview if @equation
    @equation = nil
  end

  def remove_number_bottons
    number_buttons.each { |button|
      button.removeFromSuperview
    }
    number_buttons
  end


  def make_button(pos, withValue:val, forSuccess:success)
    action_for_button = success ? "action_tapped_happy:" : "action_tapped_sad:"
    margin = 10
    width = height = (view.frame.size.width - margin * 4) / 3
    top_y = 150
    button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    button.setTitle(val.to_s, forState:UIControlStateNormal)
    button.addTarget(self, action: action_for_button , forControlEvents:UIControlEventTouchUpInside)
    button.frame = [[(pos % 3) * (margin + width) + margin, top_y + ((pos / 3) * (margin + height)) ], [width, height]]
    button
  end

  def action_tapped_sad(sender)
    @fail_sound.play
  end

  def action_tapped_happy(sender)
    UIView.animateWithDuration(1.25,
                               animations:lambda {
                                   @equation.label.alpha = 0
                                   @equation.label.transform = CGAffineTransformMakeScale(0.1, 0.1)
                                   @applause_sound.play
                               },
                               completion:lambda { |finished|
                                   @equation.label.text = @equation.label.text.gsub(/\?/, sender.currentTitle)
                                   UIView.animateWithDuration(6,
                                                    animations:lambda {
                                                        @equation.label.alpha = 1
                                                        @equation.label.transform = CGAffineTransformIdentity
                                                    },
                                                    completion:lambda { |finished|
                                                        remove_equation_and_number_buttons
                                                        add_equation_and_number_buttons
                                                    })
                               })
  end

  def load_sound_effects
    @fail_sound =     load_caf_sound 'fail-buzzer'
    @applause_sound = load_caf_sound 'applause'
  end
  
  def load_caf_sound(name)
    path = NSBundle.mainBundle.pathForResource(name, ofType:'caf')
    url = NSURL.fileURLWithPath(path)
    error_ptr = Pointer.new(:id)
    sound = AVAudioPlayer.alloc.initWithContentsOfURL(url,error:error_ptr)
    unless sound
      raise "Can't open sound file: #{error_ptr[0].description}"
    end
    sound
  end
end
