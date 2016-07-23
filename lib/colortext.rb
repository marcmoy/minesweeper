require 'colorize'

COLORTEXT = Hash.new{|h,k,v| h[k] = k.to_s.colorize(:color => :black, :background => :light_white)}

COLORTEXT[:F] = "F".colorize(:color => :red, :background => :light_white)
COLORTEXT[:B] = "".colorize(:color => :red, :background => :red)
COLORTEXT[1] = "1".colorize(:color => :blue, :background => :light_white)
COLORTEXT[2] = "2".colorize(:color => :green, :background => :light_white)
COLORTEXT[3] = "3".colorize(:color => :light_red, :background => :light_white)
COLORTEXT[4] = "4".colorize(:color => :light_blue, :background => :light_white)
COLORTEXT[5] = "5".colorize(:color => :cyan, :background => :light_white)
COLORTEXT[6] = "6".colorize(:color => :magenta, :background => :light_white)
