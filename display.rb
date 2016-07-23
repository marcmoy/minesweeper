require 'colorize'

require_relative 'board'
require_relative 'cursorable'

class Display
  include Cursorable
  CURSOR_COLOR = :blue
  SELECTED_COLOR = :red
  BACKGROUND_COLOR = :light_white

  attr_reader :board, :cursor_pos, :selected_pos

  def initialize(board)
    @board = board
    @cursor_pos = [0,0]
    @selected_pos = nil
  end

  def move(new_pos)
    @cursor_pos = new_pos
  end

  def render(over = false)
    system('clear')
    0.upto(board.size - 1) do |row|
      str_row = ""
      0.upto(board.size - 1) do |col|
        color = BACKGROUND_COLOR
        color = CURSOR_COLOR if cursor_pos == [row, col]
        color = SELECTED_COLOR if selected_pos == [row, col]
        tile = board.grid[row][col]
        tile.reveal if over
        str_row << " #{tile} ".colorize(background: color)
      end
      puts str_row
    end
  end

end

if __FILE__ == $PROGRAM_NAME
  b = Board.new
  d = Display.new(b)
  while true
    d.render
    d.get_input
  end
end
