require_relative 'board'
require_relative 'display'
require 'yaml'
require 'byebug'

class MineSweeper

  attr_reader :board, :game_over, :reveal_count, :display

  def initialize(board)
    @board = board
    @game_over = false
    @reveal_count = 0
    @display = Display.new(board)
  end

  def run
    play_turn until game_over || won?
    display.render(true)
    print_result
  end

  def play_turn
    process_input(get_input)
  end

  def get_input
    display.get_input
  end

  def process_input(input)
    return if input.nil?
    return save_game if input == "s"
    return load_game if input == "l"
    option, pos = input
    option == :f ? process_flag(pos) : process_reveal(pos)
  end

  def process_flag(pos)
    board[*pos].toggle_flag
  end

  def process_reveal(pos)
    if board[*pos].bomb
      @game_over = true
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
      puts "\nYou win!"
    else
      puts "\nYou lose!"
    end
  end

  def save_game
    puts "Saved!"
    File.write('saved_game', YAML.dump(self))
    exit
  end

  def load_game
    print "Loading last game"
    sleep(0.5)
    3.times{ print "."; sleep(1) }
    YAML.load_file('saved_game').run
  end

end

def get_level
  loop do
    print_game_levels
    level = gets.chomp.to_i
    return level if level.between?(1,3)
    puts "Invalid entry! Enter 1, 2, or 3"
    sleep(2)
  end
end

def print_game_levels
  puts "\n"
  puts "Level 1: easy"
  puts "Level 2: medium"
  puts "Level 3: hard"
  puts "\n"
  puts "What level would you like to play?"
  print "<"
end

def print_header
    puts '    __  ___
   /  |/  /_____  ___  ______      _____  ___  ____  _____
  / /|_/ / / __ \/ _ \/ ___| | /| / / _ \/   \/ __ \/ ___/
 / /  / / / / / /  __(__  )| |/ |/ /  __/ -- /  ___/ /
/_/  /_/_/_/ /_/\___/____/ |__/|__/\___// __/ \___/_/
                Developed by @MarcMoy  /_/'
    puts "\n "
    puts "Welcome to Minesweeper!".underline
end

if __FILE__ == $PROGRAM_NAME
  system('clear')
  print_header
  level = get_level
  board = nil

  case level
  when 1
    board = Board.new(9, 10)
  when 2
    board = Board.new(16, 40)
  when 3
    board = Board.new(32, 160)
  end

  game = MineSweeper.new(board)
  game.run
end
