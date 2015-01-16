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
  
  def count_stack_height
  end
  
  def over?
  end
  
  def spawn_piece
  end
  
  def line_to_clear?
  end
  
  def clear_line
  end
  
  def lock_board
  end
  
  def lower_piece
  end
  
  def num_turns
  end
  
end
