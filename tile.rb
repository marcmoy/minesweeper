require 'colorize'

class Tile

  attr_reader :bomb, :face_up, :num_adj_bombs, :flagged
  attr_writer :num_adj_bombs, :bomb

  def initialize(bomb = false)
    @bomb = bomb
    @face_up = false
    @num_adj_bombs = 0
    @flagged = false
  end

  def to_s
    return "*" unless face_up
    if @bomb
      ""
    else
      num_adj_bombs == 0 ? "_" : num_adj_bombs.to_s
    end
  end

  def reveal
    @face_up = true
  end

  def toggle_flag
    @flagged = !@flagged
  end

end
