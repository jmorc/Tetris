require_relative 'computer_player'

class Game
  def initialize(board = Board.new)
    @board = board
    @player = ComputerPlayer.new(@board)
  end
  
  def play
    while !self.over?
      spawn_tetronimo
    end
  end
  
  def play_tetronimo
    @board.spawn_tetronimo 
    @computer_player.optimize_target
    while @board.current_tetronimo
      step_game
    end
    @computer_player.target_pos = nil
  end
    
  def step_game
    if @computer_player.ready_to_drop?
      @computer_player.drop
      @board.lock_tetronimo
    else
      @computer_player.step
      @board.lower_tetronimo
    end
  end
  
  def over?
    @board.over?
  end
end