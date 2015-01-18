require_relative 'board'

class ComputerPlayer
  attr_accessor :board
  
  def initialize(board)
    @board = board
  end
  
  def count_pocket_spaces
  end
  
  def count_overhang_spaces
  end
  
  def count_vertical_faces
  end
    
  def drop_tetronimo
  end
  
  def maximize_line_clears
  end

  def move_left
  end
  
  def move_right
  end
  
  def optimize_placement
    optimial_pos = nil
    lines_clears = 0
    
    (-3..19).each do |row|
      (-3..9).each do |col|
        dupped_board = @board.dup_board
        dupped_board.current_tetronimo.pos = [row, col]
        
        next unless dupped_board.valid_locking_position?
        dupped_board.lock_tetronimo
        current_lines_clears = dupped_board.rows_to_clear.count
        
        dupped_board.render
        
        if current_lines_clears > lines_clears
          optimial_pos = [row, col] 
        end
      end
    end
    
    
    # 1. Maximize lines clears - done
    # 2. Minimize piece_stack_height
    # 3. Minimize exposed vertical spaces 
    # 4. Minimize enclosed (pocket) spaces - may skip this
    # 5. Minimize overhanging spaces - may skip this
     
    optimial_pos 
  end
  
  def rotate_current_piece
  end
end