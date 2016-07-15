require_relative "tile"
require "byebug"
require_relative "monkeypatch"



class Board
  attr_reader :size, :num_bombs
  attr_accessor :grid

  def initialize(size = 9, num_bombs = 10)
    @size = size
    @num_bombs = num_bombs
    @grid = Array.new(size) { Array.new(size) }
    populate
  end

  def populate
    bomb_pos = (0..size ** 2 - 1).to_a.sample(num_bombs)
    tile_num = 0

    grid.each_with_index do |row, i|
      row.each_with_index do |col, j|
        self[i, j] = Tile.new([i, j])
        self[i, j].bomb = true if bomb_pos.include?(tile_num)

        tile_num += 1
      end
    end
  end

  def render
    puts "  #{(0..size - 1).to_a.join(" ")}"
    grid.each_with_index do |row, i|
      tiles = row.map(&:to_s)
      puts "#{i} #{tiles.join(" ")}"
    end
    nil
  end

  def assign_num_adj_bombs(*pos)
    self[*pos].num_adj_bombs = count_nearby_bombs(pos)
  end

  def count_nearby_bombs(pos)
    bomb_count = 0

    adjacent_tiles(pos).each { |tile| bomb_count += 1 if tile.bomb }
    bomb_count
  end

  def adjacent_tiles(pos)
    adj_tiles = []
    x, y = pos

    [-1,1].each do |i|

      adj_tiles << self[x + i, y] if (x + i >= 0) && self[x + i, y] != nil
      adj_tiles << self[x, y + i] if (y + i >= 0) && self[x, y + i] !=  nil
      adj_tiles << self[x + i, y + i] if (x + i >= 0) && (y + i >= 0) && self[x + i, y + i] != nil
      adj_tiles << self[x + i, y - i] if (x + i >= 0) && (y - i >= 0) && self[x + i, y - i] != nil

    end
    adj_tiles
  end

  def [](*pos)
    row, col = pos
    grid[row][col]
  end

  def []=(*pos, value)
    row, col = pos
    grid[row][col] = value
  end

end
