require 'colorize'
require_relative 'board'
require_relative 'cursorable'

class Display
  include Cursorable
  CURSOR_COLOR = :blue
  BACKGROUND_COLOR = :light_white

  attr_reader :board, :cursor_pos, :prev_cursor

  def initialize(board)
    @board = board
    @grid = board.grid
    @cursor_pos = [0,0]
    @prev_cursor = [1,0]
    @x = board.x
    @y = board.y
  end

  def render(game_over = false)
    system('clear')
    set_cursor_background_color
    @grid.each do |row|
      puts row.join("")
    end
    print_instructions
  end

  def set_cursor_background_color
    board[prev_cursor].background = :light_white
    board[cursor_pos].background = :light_blue
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
  #render test for expert level board
  #largest board possible

  b = Board.new(16, 30, 99)
  d = Display.new(b)
  while true
    d.render
    d.get_input
  end
end
