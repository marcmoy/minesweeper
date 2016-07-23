require_relative 'board'
require_relative 'display'
require 'yaml'
require 'byebug'

class MineSweeper

  attr_reader :board, :game_lost, :reveal_count, :display

  def initialize(board = Board.new)
    @board = board
    @game_lost = false
    @reveal_count = 0
    @display = Display.new(board)
  end

  def run
    play_turn until game_lost || won?
    display.render(true)
  end

  def play_turn
    process_input(get_input)
  end

  def get_input
    display.get_input
  end

  def valid_move?(move)
    return true if move == "s" || move == "l"
    option, pos = move

    if [:f,:r].include?(option) &&
      pos.all?{|n| n.between?(0,board.size - 1)}

      return true unless board[*pos].face_up
    end
    false
  end

  def process_input(input)
    return if input.nil?
    option, pos = input
    option == :f ? process_flag(pos) : process_reveal(pos)
  end

  def process_flag(pos)
    board[*pos].toggle_flag
  end

  def process_reveal(pos)
    if board[*pos].bomb
      @game_lost = true
    else
      reveal_safe_tiles(pos)
    end
  end

  def reveal_safe_tiles(pos)
    tile = board[*pos]
    tile.reveal
    @reveal_count += 1
    if tile.num_adj_bombs == 0
      board.adjacent_tiles(pos).each do |adj_tile|
        reveal_safe_tiles(adj_tile.pos) unless adj_tile.face_up
      end
    end
  end

  def won?
    reveal_count == board.size ** 2 - board.num_bombs
  end

  def print_result
    if won?
      puts "You win!"
    else
      puts "You lose!"
    end
  end

  def save_game
    puts "Saved!"
    File.write('saved_game', YAML.dump(self))
  end

  def load_game
    YAML.load_file('saved_game').run
  end

end

if __FILE__ == $PROGRAM_NAME
  my_board = Board.new
  my_game = MineSweeper.new(my_board)
  my_game.run
end
