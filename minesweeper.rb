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

end
