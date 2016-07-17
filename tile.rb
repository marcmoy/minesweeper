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
    return COLORTEXT[:*] unless face_up || flagged
    return COLORTEXT[:F] if flagged && !face_up

    if @bomb
      COLORTEXT[:B]
    else
      num_adj_bombs == 0 ? COLORTEXT[:_] : COLORTEXT[num_adj_bombs]
    end
  end

  def to_s_full
    if @bomb
      COLORTEXT[:B]
    else
      num_adj_bombs == 0 ? COLORTEXT[:_] : COLORTEXT[num_adj_bombs]
    end
  end

  def reveal
    @face_up = true
  end

  def toggle_flag
    @flagged = !@flagged
  end

end
