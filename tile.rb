require 'colorize'

class Tile

  attr_reader :face_up, :flagged
  attr_accessor :num_adj_bombs, :bomb, :pos

  def initialize(pos = [0, 0],bomb = false)
    @bomb = bomb
    @face_up = false
    @num_adj_bombs = 0
    @flagged = false
    @pos = pos
  end

  def to_s
    return "*".colorize(:color => :black, :background => :light_blue) unless face_up || flagged
    return "F".colorize(:color => :red, :background => :light_blue) if flagged && !face_up

    if @bomb
      "".colorize(:color => :black, :background => :red)
    else
      num_adj_bombs == 0 ? "_".colorize(:color => :black, :background => :light_blue) : num_adj_bombs.to_s.colorize(:color => :black, :background => :light_blue)
    end
  end

  def to_s_debug
    # return "*" unless face_up || flagged
    # return "F" if flagged && !face_up

    if @bomb
      "".colorize(:color => :black, :background => :red)
    else
      num_adj_bombs == 0 ? "_".colorize(:color => :black, :background => :light_blue) : num_adj_bombs.to_s.colorize(:color => :black, :background => :light_blue)
    end
  end

  def reveal
    @face_up = true
  end

  def toggle_flag
    @flagged = !@flagged
  end

end
