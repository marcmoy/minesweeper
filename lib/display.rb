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
    @grid = board.grid
  end

  def render(game_over = false)
    system('clear')
    @grid.each do |row|
    end
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
