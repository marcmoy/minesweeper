require 'colorize'

class Tile

  attr_reader :face_up, :flagged
  attr_accessor :num_adj_bombs, :bomb, :pos, :cursor, :value, :background

  def initialize(pos = [0, 0],bomb = false)
    @bomb = bomb
    @face_up = false
    @num_adj_bombs = 0
    @flagged = false
    @pos = pos
    @cursor = false
    @background = :light_white
    @value = :*
  end

  def to_s
    COLORTEXT[value].colorize(background: @background)
  end

  def background
    @cursor ? :light_blue : :light_white
  end

  def reveal
    @face_up = true
    @value = num_adj_bombs
  end

  def toggle_flag
    @flagged = !@flagged

    if @flagged
      @value = :F
    else
      @value = num_adj_bombs
    end
  end

  COLORTEXT = Hash.new{|h,k,v| h[k] = k.to_s.colorize(:color => :black)}
  COLORTEXT[:F] = " 🚩 ".colorize(:color => :red)
  COLORTEXT[:B] = " 💣 ".colorize(:color => :black)
  COLORTEXT[:E] = " 💥 ".colorize(:color => :black)
  COLORTEXT[1] = " 1 ".colorize(:color => :blue)
  COLORTEXT[2] = " 2 ".colorize(:color => :green)
  COLORTEXT[3] = " 3 ".colorize(:color => :light_red)
  COLORTEXT[4] = " 4 ".colorize(:color => :light_blue)
  COLORTEXT[5] = " 5 ".colorize(:color => :cyan)
  COLORTEXT[6] = " 6 ".colorize(:color => :magenta)
  COLORTEXT[:*] = " * ".colorize(:color => :black)

end
