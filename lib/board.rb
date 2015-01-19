require_relative 'tetromino'

class Board
  attr_accessor :grid, :current_tetromino
  
  def initialize
    @grid = Array.new(20) { Array.new(10, nil) }
    @current_tetromino = nil
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
      stack_height += 1 if grid[row].any? { |el| el == 1 }
    end
    
    stack_height
  end
  
  def count_intrarow_transitions
    transitions = 0
    (0..19).each do |row|
      (1..9).each do |col|
        transitions += 1 if grid[row][col] != grid[row][col - 1]
      end
    end
    
    transitions  
  end
  
  def dup_board(pos = nil)
    dupped_board = Board.new
    (0..19).each do |row|
      (0..9).each do |col|
        dupped_board.grid[row][col] = self.grid[row][col]
      end
    end
    
    unless self.current_tetromino.nil?
      dupped_tetromino = self.current_tetromino.dup_tetromino
      dupped_board.current_tetromino = dupped_tetromino
      dupped_tetromino.pos = pos unless pos.nil?
    end
    
    dupped_board
  end
  
  def lock_tetromino
    (0..3).each do |row|
      board_row = @current_tetromino.pos[0] + row
      (0..3).each do |col|
        board_col = @current_tetromino.pos[1] + col
        
        if @current_tetromino.shape[row][col] == 1 &&
          (board_row.between?(0, 19) && board_col.between?(0, 9))
          self[[board_row, board_col]] = 1
        end
      end
    end
    
    self.current_tetromino = nil
  end
  
  def lower_tetromino 
    @current_tetromino.pos[0] = @current_tetromino.pos[0] - 1
  end
  
  def move_left
    pos = @current_tetromino.pos
    possible_pos = [pos[0], pos[1] - 1]
    dup_board = self.dup_board(possible_pos)
    @current_tetromino.pos[1] -= 1 if dup_board.valid_pos? 
  end
  
  def move_right
    pos = @current_tetromino.pos
    possible_pos = [pos[0], pos[1] + 1]
    dup_board = self.dup_board(possible_pos)
    @current_tetromino.pos[1] += 1 if dup_board.valid_pos? 
  end
  
  def over?
    self.count_stack_height == 20
  end
  
  def render
    # render board to terminal
    line_str = ""
    19.downto(0) do |row|
      (0..9).each do |col|
        if tetromino_in_pos?([row, col])
          line_str << "O"
        else
          self[[row, col]].nil? ? line_str << "." : line_str << "#"
        end
      end
      line_str << "\n"
    end
    
    puts line_str
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
  
  def spawn_tetromino
    # the only shape in this iteration is O_TETROMINO
    shape = Tetromino::O_TETROMINO[0]
    @current_tetromino = Tetromino.new(shape)
  end
  
  def sweep_rows
    rows = rows_to_clear
    rows.sort! { |x, y| y <=> x }
    rows.each do |row|
      self.clear_row(row)
    end
  end
  
  def tetromino_in_pos?(pos)
    # tetromino_in_pos? checks if a grid square contains a tetromino segment.
    # It is only used for rendering the board.
    return if @current_tetromino.nil?
    (0..3).each do |row|
      board_row = @current_tetromino.pos[0] + row
      (0..3).each do |col|
        board_col = @current_tetromino.pos[1] + col
        if @current_tetromino.shape[row][col] == 1 &&
          [board_row, board_col] == pos
          return true
        end
      end
    end

    false
  end

  def valid_pos?
    # check if position is out of bounds, or already filled
    valid = true
    (0..3).each do |row|
      board_row = @current_tetromino.pos[0] + row
      (0..3).each do |col|
        board_col = @current_tetromino.pos[1] + col
        
        if @current_tetromino.shape[row][col] == 1
          if !(board_row.between?(0, 19) && board_col.between?(0, 9)) 
            valid = false 
          elsif !self[[board_row, board_col]].nil? 
            valid = false 
          end
        end
      end
    end
    
    valid
  end
  
  def valid_locking_pos?
    # check that the tetromino has something beneath it
    valid = false
    (0..3).each do |row|
      board_row = @current_tetromino.pos[0] + row
      valid = true if board_row == 0
      (0..3).each do |col|
        board_col = @current_tetromino.pos[1] + col
        next if board_row > 20
        if @current_tetromino.shape[row][col] == 1 &&
          self[[board_row - 1, board_col]] == 1
          valid = true
        end
      end
    end
    
    valid
  end
end