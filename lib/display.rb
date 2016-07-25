require 'colorize'
require_relative 'board'
require_relative 'cursorable'

class Display
  include Cursorable
  CURSOR_COLOR = :blue
  BACKGROUND_COLOR = :light_white

  attr_reader :board, :cursor_pos, :selected_pos

  def initialize(board)
    @board = board
    @cursor_pos = [0,0]
    @selected_pos = nil
  end

  def render(game_over = false)
    system('clear')
    0.upto(board.size - 1) do |row|
      str_row = ""
      0.upto(board.size - 1) do |col|
        color = BACKGROUND_COLOR
        color = CURSOR_COLOR if cursor_pos == [row, col]
        tile = board.grid[row][col]
        if game_over
          tile.reveal
          tile = COLORTEXT[:E] if tile.bomb
        end
        str_row << " #{tile} ".colorize(background: color)
      end
      puts str_row
    end
    print_instructions
  end

  def print_instructions
    puts "\nKEY     FUNCTION".underline
    puts "[enter] reaveal tile"
    puts "[f]     toggle flag"
    puts "[s]     save current game"
    puts "[l]     load last saved game"
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
