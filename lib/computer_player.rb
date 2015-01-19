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
    
    @target_pos = optimial_pos 
  end
  
  def ready_to_drop?
    @target_pos[1] == tetronimo_pos[1] 
  end
  
  def step
    return if @board.current_tetronimo.nil?
    dupped_board = @board.dup_board
    if tetronimo_pos[1] < @target_pos[1]  
      dupped_board.move_right
      if dupped_board.valid_position?
        @board.move_right
      end
    elsif tetronimo_pos[1] > @target_pos[1]
      dupped_board.move_left
      if dupped_board.valid_position?
        @board.move_left
      end
    end
  end
  
  def tetronimo_pos
    @board.current_tetronimo.pos
  end
end