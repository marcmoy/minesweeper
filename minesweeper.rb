require_relative 'board'

class MineSweeper

  attr_reader :board

  def initialize(board = Board.new)
    @board = board
  end

  def prompt
    puts "Enter position in 'f x,y' to toggle flag."
    puts "Enter position in 'r x,y' to reveal."
    print "<"
  end

  def prompt_try_again
    puts "Wrong input. Try again."
  end

  def parse_input(str)
    option = str[0].to_sym
    pos = str.split(" ")[1].split(",").map(&:to_i)
    [option, pos]
  end

  def valid_input?(move)
    option, pos = move

    if [:f,:r].include?(option) &&
      pos.all?{|n| n.between?(0,board.size - 1)}

      return true unless board[*pos].face_up
    end
    false
  end

  def get_input
    input = nil
    loop do
      prompt
      input = parse_input(gets.chomp)
      break if valid_input?(input)
      prompt_try_again
    end

    input
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
      game_over
    else

    end
  end

  def reveal_safe_tiles(pos)
    tile = board[*pos]
    tile.reveal
    if tile.num_adj_bombs == 0
      board.adjacent_tiles(pos).each do |adj_tile|
        reveal_safe_tiles(adj_tile.pos)
      end
    end
  end

end
