require_relative 'board'
require_relative 'display'
require 'yaml'
require 'byebug'

class MineSweeper

  attr_reader :board, :game_over, :reveal_count, :display

  def self.play
    game = MineSweeper.new
    game.run
  end

  def initialize
    @level = get_level
    @board = Board.new(@level)
    @game_over = false
    @reveal_count = 0
    @display = Display.new(board)
  end

  def run
    play_turn until game_over || won?
    board.reveal_tiles(won?) #explodes bombs if game lost
    display.render
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
    tile = board[pos]
    tile.toggle_flag unless tile.face_up
  end

  def process_reveal(pos)
    tile = board[pos]
    if tile.bomb
      @game_over = true
    elsif tile.flagged
      return nil
    else
      reveal_safe_tiles(pos)
    end
  end

  def reveal_safe_tiles(pos)
    tile = board[pos]
    tile.reveal
    @reveal_count += 1
    if tile.num_adj_bombs == 0
      board.adjacent_tiles(pos).each do |adj_tile|
        reveal_safe_tiles(adj_tile.pos) unless adj_tile.face_up
      end
    end
  end

  def won?
    reveal_count == board.size - board.num_bombs
  end

  def print_result
    if won?
      puts "\nYou win!\n"
    else
      puts "\nYou lose!\n"
    end
  end

  def save_game
    puts "Saved!"
    File.write("level_#{@level}_saved_game", YAML.dump(self))
    exit
  end

  def load_game
    print "Loading last game"
    sleep(0.5)
    3.times{ sleep(1); print "." }
    YAML.load_file("level_#{@level}_saved_game").run
  end

  def get_level
    loop do
      print_game_levels
      level = gets.chomp.to_i
      return level if level.between?(1,3)
      puts "Invalid level! Enter 1, 2, or 3"
      sleep(1.5)
    end
    print "loading game"
    3.times{ sleep(1); print "." }
  end

  def print_header
    system('clear')

      puts '
      __  ___
     /  |/  /_____  ___  ______      _____  ___  ____  _____
    / /|_/ / / __ \/ _ \/ ___| | /| / / _ \/   \/ __ \/ ___/
   / /  / / / / / /  __(__  )| |/ |/ /  __/ -- /  ___/ /
  /_/  /_/_/_/ /_/\___/____/ |__/|__/\___// __/ \___/_/
                  Developed by @MarcMoy  /_/'
      puts "\n "
      puts "Welcome to Minesweeper!".underline

  end

  def print_game_levels
    print_header
    puts "\n"
    puts "Level 1: easy"
    puts "Level 2: medium"
    puts "Level 3: hard"
    puts "\n"
    puts "What level would you like to play?"
    print "<"
  end

end

if __FILE__ == $PROGRAM_NAME
  system('clear')
  MineSweeper.play
end
