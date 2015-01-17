require_relative 'tetronimo'

class Board
  attr_accessor :grid, :current_tetronimo
  
  def initialize
    @grid = Array.new(20) { Array.new(10, nil) }
    @current_tetronimo = nil
  end
  
  def [](pos)
    x, y = pos
    @grid[x][y]
  end
  
  def []=(pos, num)
    x, y = pos
    @grid[x][y] = num
  end
  
  def clear_row(row)
    dupped_board = self.dup_board
    
    (row..18).each do |this_row|
      self.grid[this_row] = dupped_board.grid[this_row + 1]
    end
    
    self.grid[19] = Array.new(10, nil)
  end
  
  def count_stack_height
    stack_height = 0
    
    (0..19).each do |row|
      row_empty = false
      row_empty = true unless self.grid[row].any? { |el| el == 1 }
      return stack_height if row_empty
      stack_height += 1
    end
    
    stack_height
  end
  
  def dup_board
    dupped_board = Board.new
    (0..19).each do |row|
      dupped_board.grid[row] = self.grid[row]
    end
    
    dupped_board
  end
  
  
  def over?
    self.count_stack_height == 20
  end
  
  def lock_board
  end
  
  def lower_tetronimo
    @current_tetronimo.pos[0] = @current_tetronimo.pos[0] - 1
  end
  
  def num_turns
  end
  
  def spawn_tetronimo
    shape = Tetronimo::O_TETRONIMO[0]
    @current_tetronimo = Tetronimo.new(shape)
  end
  
  def track_tetronimo
    (0..3).each do |row|
      board_row = @current_tetronimo.pos[0] + row
      
      (0..3).each do |col|
        board_col = @current_tetronimo.pos[1] + col
        
        if @current_tetronimo.shape[row][col] == 1 &&
          (board_row.between?(0, 19) && board_col.between?(0, 9)) 
          self[[board_row, board_col]] = "T"
        end
      end
    end
  end
  
  def rows_to_clear
    target_rows = []
    (0..19).each do |row|
      if self.grid[row].all? { |el| el == 1 }
        target_rows << row
      end
    end
    
    target_rows 
  end
  
  def valid_position?
    valid = true
    (0..3).each do |row|
      board_row = @current_tetronimo.pos[0] + row
      
      (0..3).each do |col|
        board_col = @current_tetronimo.pos[1] + col
        
        if @current_tetronimo.shape[row][col] == 1
          if !(board_row.between?(0, 19) && board_col.between?(0, 9)) 
            valid = false # position is out of bounds
          elsif !self[[board_row, board_col]].nil? 
            valid = false #position is already filled 
          end
          
        end
      end
    end
    
    valid
  end
  
  def valid_locking_position?
    
  end
end
