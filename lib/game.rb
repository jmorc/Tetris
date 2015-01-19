require_relative 'computer_player'

class Game
  attr_accessor :moves, :player, :board
  
  def initialize(board = Board.new)
    @board = board
    @player = ComputerPlayer.new(@board)
    @max_moves = 100
    @moves = 0
  end
  
  def play
    while !self.over?
      play_tetronimo
    end
    @moves == @max_moves ? @player.status = 'winner' : @player.status = 'loser'
  end
  
  def play_tetronimo
    @board.spawn_tetronimo 
    @player.optimize_target # should check if optimal position is reachable
    while @board.current_tetronimo
      step_game
    end
    
    @board.rows_to_clear.each { |row| @board.clear_row(row) }
    @player.target_pos = nil
    @moves += 1
  end
    
  def step_game
    if @player.ready_to_drop? # seem to be able to drop through filled areas
      @player.drop
      @board.lock_tetronimo
    else
      @player.step # should check if step is valid
      @board.lower_tetronimo # should lock tetronimo if cannot lower
      system 'clear'
      @board.render
    end
  end
  
  def over?
    @board.over? || @moves == @max_moves
  end
end