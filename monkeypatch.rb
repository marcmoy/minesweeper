class NilClass

  def bomb
    false
  end

  def [](*pos)
    nil
  end

  def []=(*pos, value)
    nil
  end

end
