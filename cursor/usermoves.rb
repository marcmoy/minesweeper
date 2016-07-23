require_relative 'keypress'
require_relative 'board'


positions = Array.new(9){Array.new(9)}


CSI = "\e["

def move_cursor(board)
  board.render
  $stdout.write "#{CSI}2;3H"
  loop do
    c = read_char
    break if c == "a"
    if c == "\r"

    end
    $stdout.write c
    $stdout.write "#{CSI}s"
  end
end

if __FILE__ == $PROGRAM_NAME
  board = Board.new
  move_cursor(board)
end