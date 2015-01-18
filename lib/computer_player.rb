require_relative 'board'

class ComputerPlayer
  attr_accessor :board
  
  def initialize(board)
    @board = board
  end
    
  def drop_tetronimo
  end

  def move_left
  end
  
  def move_right
  end
  
  def optimize_placement
    optimial_pos = nil
    lines_clears = 0
    intrarow_transitions = 1000
    
    (-3..19).each do |row|
      (-3..9).each do |col|
        dupped_board = @board.dup_board
        dupped_board.current_tetronimo.pos = [row, col]
        
        next unless dupped_board.valid_locking_position?
        dupped_board.lock_tetronimo
        current_lines_clears = dupped_board.rows_to_clear.count
        current_transitions = dupped_board.count_intrarow_transitions
        # dupped_board.render
        
        if current_lines_clears > lines_clears
          optimial_pos = [row, col] 
          lines_clears = current_lines_clears
        elsif lines_clears == current_lines_clears 
          if current_transitions < intrarow_transitions
            optimial_pos = [row, col] 
            intrarow_transitions = current_transitions
          end  
        end
      end
    end
    
    optimial_pos 
  end
  
  def rotate_current_piece
  end
end