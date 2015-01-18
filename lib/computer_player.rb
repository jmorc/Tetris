class ComputerPlayer
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
    dupped_board = @board.dup_board
    
    (0..19).each do |row|
      (0..9).each do |col|
        #set tetronimo position
        next unless.valid_locking_position?
        
      end
    end
    
    
    # 1. Maximize lines clears
    # 2. Minimize enclosed (pocket) spaces - may skip this
    # 3. Minimize overhanging spaces - may skip this
    # 4. Minimize piece_stack_height
    # 5. Minimize exposed vertical spaces   
  end
  
  def rotate_current_piece
  end
end