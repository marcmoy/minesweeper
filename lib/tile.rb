require 'colorize'

class Tile

  attr_reader :face_up, :flagged, :background
  attr_accessor :num_adj_bombs, :bomb, :pos, :cursor, :value

  def initialize(pos = [0, 0],bomb = false)
    @bomb = bomb
    @face_up = false
    @num_adj_bombs = 0
    @flagged = false
    @pos = pos
    @cursor = false
  end

  def to_s
    if face_up
      COLORTEXT[value]
    else
      COLORTEXT[:*]
    end
  end

  def background
    @cursor ? :light_blue : :light_white
  end

  def assign_value
    if bomb
      @value = :B
    else
      @value = num_adj_bombs
    end
  end

  def reveal
    @face_up = true
  end

  def toggle_flag
    @flagged = !@flagged
  end

  COLORTEXT = Hash.new{|h,k,v| h[k] = k.to_s.colorize(:color => :black, :background => :light_white)}
  COLORTEXT[:F] = "🚩".colorize(:color => :red, :background => :light_white)
  COLORTEXT[:B] = "💣".colorize(:color => :black, :background => :light_white)
  COLORTEXT[:E] = "💥".colorize(:color => :black, :background => :light_white)
  COLORTEXT[1] = "1".colorize(:color => :blue, :background => :light_white)
  COLORTEXT[2] = "2".colorize(:color => :green, :background => :light_white)
  COLORTEXT[3] = "3".colorize(:color => :light_red, :background => :light_white)
  COLORTEXT[4] = "4".colorize(:color => :light_blue, :background => :light_white)
  COLORTEXT[5] = "5".colorize(:color => :cyan, :background => :light_white)
  COLORTEXT[6] = "6".colorize(:color => :magenta, :background => :light_white)
  COLORTEXT[:*] = "*".colorize(:color => :black, :background => :light_white)

end
