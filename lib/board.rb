require_relative 'tile'

class Board
  attr_reader :size, :num_bombs, :x, :y
  attr_accessor :grid

  def initialize(x = 9, y = 9, num_bombs = 10)
    @x = x
    @y = y
    @size = x * y
    @num_bombs = num_bombs
    @grid = Array.new(x) { Array.new(y) }
    populate
  end

  def adjacent_tiles(pos)
    adj_tiles = []
    x, y = pos

    [-1,1].each do |i|

      adj_tiles << self[[x + i, y]] if (x + i >= 0) && self[[x + i, y]] != nil
      adj_tiles << self[[x, y + i]] if (y + i >= 0) && self[[x, y + i]] !=  nil
      adj_tiles << self[[x + i, y + i]] if (x + i >= 0) && (y + i >= 0) && self[[x + i, y + i]] != nil
      adj_tiles << self[[x + i, y - i]] if (x + i >= 0) && (y - i >= 0) && self[[x + i, y - i]] != nil

    end
    adj_tiles
  end

  def in_bounds?(pos)
    x, y = pos
    x.between?(0, @x - 1) && y.between?(0, @y - 1)
  end

  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    grid[row][col] = value
  end

  private

  def populate
    random_bomb_indices = 0.upto(size).to_a.sample(num_bombs)
    random_bomb_assigner = 0
    bomb = false

    0.upto(@x - 1) do |i|
      0.upto(@y - 1) do |j|
        pos = [i,j]
        bomb = true if random_bomb_indices.include?(random_bomb_assigner)

        self[pos] = Tile.new(pos, bomb)
        random_bomb_assigner += 1
        bomb = false
      end
    end

    assign_num_adj_bombs
  end

  def assign_num_adj_bombs
    0.upto(@x - 1) do |i|
      0.upto(@y - 1) do |j|
        pos = [i,j]
        self[pos].num_adj_bombs = count_nearby_bombs(pos)
      end
    end
  end

  def count_nearby_bombs(pos)
    bomb_count = 0
    adjacent_tiles(pos).each { |tile| bomb_count += 1 if tile.bomb }
    bomb_count
  end

end

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
