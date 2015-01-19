require_relative 'computer_player'

class Game
  attr_accessor :moves, :player, :board
  
  def initialize(board = Board.new, max_moves = 50)
    @board = board
    @player = ComputerPlayer.new(@board)
    @max_moves = max_moves
    @moves = 0
  end
  
  def play
    while !self.over?
      play_tetronimo
    end
    @player.status = @moves == @max_moves ? 'winner' : 'loser'
  end
  
  def play_tetronimo
    @board.spawn_tetronimo 
    @player.optimize_target 
    
    while @board.current_tetronimo
      step_game
    end
    
    @board.sweep_rows  
    @player.target_pos = nil
    @moves += 1
  end
    
  def step_game
    if @player.ready_to_drop? 
      @player.drop
      @board.lock_tetronimo
    else
      @player.step 
      @board.valid_locking_pos? ? @board.lock_tetronimo : @board.lower_tetronimo
    end
  end
  
  def over?
    @board.over? || @moves == @max_moves
  end
end