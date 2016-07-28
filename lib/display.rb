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
    @cursor_pos = [0,0]
    @prev_cursor = nil
    @x = board.x
    @y = board.y
  end

  def render(game_over = false)
    system('clear')
    
    0.upto(@x - 1) do |i|
      0.upto(@y - 1) do |j|
        end
      end
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
  b = Board.new(16, 30, 99)
  d = Display.new(b)
  while true
    d.render
    d.get_input
  end
end
