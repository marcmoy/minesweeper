require 'colorize'
require_relative 'tile'

module ColorText

  COLORTEXT = Hash.new{|h,k,v| h[k] = k.to_s.colorize(:color => :black, :background => background_color)}

  COLORTEXT[:F] = "🚩".colorize(:color => :red, :background => background_color)
  COLORTEXT[:B] = "💣".colorize(:color => :black, :background => background_color)
  COLORTEXT[:E] = "💥".colorize(:color => :black, :background => background_color)
  COLORTEXT[1] = "1".colorize(:color => :blue, :background => background_color)
  COLORTEXT[2] = "2".colorize(:color => :green, :background => background_color)
  COLORTEXT[3] = "3".colorize(:color => :light_red, :background => background_color)
  COLORTEXT[4] = "4".colorize(:color => :light_blue, :background => background_color)
  COLORTEXT[5] = "5".colorize(:color => :cyan, :background => background_color)
  COLORTEXT[6] = "6".colorize(:color => :magenta, :background => background_color)
  COLORTEXT[:*] = "*".colorize(:color => :black, :background => background_color)

end
