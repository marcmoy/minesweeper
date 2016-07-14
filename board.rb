require_relative "tile"
require "byebug"

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
        self[i, j] = Tile.new
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

  #needs to be tested
  def assign_num_adj_bombs(pos)
    self[pos].num_adj_bombs = count_nearby_bombs(pos)
  end

  #needs to be tested
  def count_nearby_bombs(pos)
    bomb_count = 0
    x, y = *pos
    [-1,1].each do |i|

      bomb_count += 1 if grid[x + i, y].bomb && (x + i > 0)
      bomb_count += 1 if grid[x, y + i].bomb && (y + i > 0)
      bomb_count += 1 if grid[x + i, y + i].bomb && (x + i > 0) && (y + i > 0)
      bomb_count += 1 if grid[x + i, y - i].bomb && (x + i > 0) && (y - i > 0)

    end
    bomb_count
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
