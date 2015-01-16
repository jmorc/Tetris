class Board
  attr_accessor :grid
  
  def initialize
    @grid = Array.new(20) { Array.new(10, nil) }
  end
  
  def [](pos)
    x, y = pos
    @grid[x][y]
  end
  
  def []=(pos, num)
    x, y = pos
    @grid[x][y] = num
  end
  
  def clear_line
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
  
  def lower_piece
  end
  
  def num_turns
  end
  
  def spawn_piece
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
end
