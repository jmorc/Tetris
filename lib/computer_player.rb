require_relative 'board'

class ComputerPlayer
  attr_accessor :board, :target_pos, :status
  
  def initialize(board)
    @board = board
    @target_pos = nil
    @status = ""
  end
  
  def drop
    @board.current_tetronimo.pos = @target_pos
  end
  
  def optimize_target
    # optimizes first by which locking position clears the most rows, and second by which locking position leaves the fewest gaps in the rows (as approximated by intrarow_transitions)
    optimial_pos, row_clears, intrarow_transitions = nil, 0, 1000
    
    (-3..19).each do |row|
      (-3..9).each do |col|
        dup_board = @board.dup_board([row, col])
        next unless dup_board.valid_pos? && dup_board.valid_locking_pos?
        
        dup_board.lock_tetronimo
        current_row_clears = dup_board.rows_to_clear.count
        current_transitions = dup_board.count_intrarow_transitions
        
        if current_row_clears > row_clears
          optimial_pos = [row, col] 
          row_clears = current_row_clears
        elsif row_clears == current_row_clears 
          if current_transitions < intrarow_transitions
            optimial_pos = [row, col] 
            intrarow_transitions = current_transitions
          end  
        end
      end
    end
    
    @target_pos = optimial_pos 
  end
  
  def ready_to_drop?
    @target_pos[1] == tetronimo_pos[1] 
  end

  def step
    if self.tetronimo_pos[1] < @target_pos[1]  
        @board.move_right
    elsif self.tetronimo_pos[1] > @target_pos[1]
        @board.move_left
    end
  end
  
  def tetronimo_pos
    @board.current_tetronimo.pos
  end
end