class Game
  def initialize
  end
  
  def play
  end
  
  def step_game
    board.spawn_tetronimo if board.current_tetronimo == nil
    computer_player.move
    board.lower_tetronimo
    game_over = true ?  self.over? : false
  end
  
  def over?
  end
end