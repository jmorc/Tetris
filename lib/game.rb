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
  
  def spawn_tetronimo
    @board.spawn_tetronimo 
    @computer_player.optimize_placement
    while @board.current_tetronimo
      step_game
    end
  end
    
  def step_game
    if @computer_player.ready_to_drop
      @computer_player.drop
    else
      @computer_player.move_toward_goal
      board.lower_tetronimo
    end
  end
  
  def over?
    @board.over?
  end
end