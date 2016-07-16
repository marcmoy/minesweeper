require_relative 'board'

class MineSweeper

  attr_reader :board, :game_lost, :reveal_count

  def initialize(board = Board.new)
    @board = board
    @game_lost = false
    @reveal_count = 0
  end

  def run
    play_turn until game_lost || won?
    board.render_debug
    print_result
  end

  def play_turn
    board.render
    process_input(get_input)
  end

  def prompt
    puts "Enter position in 'f x,y' format to toggle flag."
    puts "Enter position in 'r x,y' format to reveal."
    print "<"
  end

  def prompt_try_again
    puts "Wrong input. Try again."
  end

  def get_input
    input = nil

    loop do
      prompt

      input = gets.chomp
      next unless valid_entry?(input)

      input = parse_input(input)

      break if valid_move?(input)
      prompt_try_again
    end

    input
  end

  def valid_entry?(input)
    begin
      parse_input(input)
      true
    rescue
      prompt_try_again
      false
    end
  end

  def parse_input(str)
    option = str[0].downcase.to_sym
    pos = str.split(" ")[1].split(",").map(&:to_i)
    [option, pos]
  end

  def valid_move?(move)
    begin
      option, pos = move

      if [:f,:r].include?(option) &&
        pos.all?{|n| n.between?(0,board.size - 1)}

        return true unless board[*pos].face_up
      end
      false

    rescue
      false
    end
  end

  def process_input(input)
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
    board.assign_num_adj_bombs(*pos)
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

end

if __FILE__ == $PROGRAM_NAME
  my_board = Board.new
  my_game = MineSweeper.new(my_board)
  my_game.run
end
