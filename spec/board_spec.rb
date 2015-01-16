require 'rspec'
require 'board'

describe Board do
  describe '#initialize' do
    subject(:board) {Board.new}
    
    it 'sets up a grid with 20 rows' do
      expect(board.grid.count).to eq(20)
    end
    
    it 'sets up a grid with 10 columns' do
      expect(board.grid[1].count).to eq(10)
    end
  end
  
  describe '#[]= and #[]' do
    b = Board.new
    b[[1, 1]] = 1
    
    it 'sets a grid position' do
      expect(b.grid[1][1]).to eq(1)
    end
    
    it 'gets a grid position' do
      expect(b[[1, 1]]).to eq(1)
    end
  end
  
  describe '#count_stack_height' do
    subject(:board) {Board.new}
    
    it 'counts the height of some pieces' do
      (0..5).each do |row|
         board[[row, 0]] = 1
      end
      
      expect(board.count_stack_height).to eq(6)
    end
  end
  
  describe '#over?' do
    subject(:board) {Board.new}
    
    it 'knows when the game is over' do
      (0..19).each do |row|
         board[[row, 0]] = 1
      end
      
      expect(board.over?).to be(true)
    end
      
    it 'knows when the game is not over' do
      (0..15).each do |row|
         board[[row, 0]] = 1
      end
      
      expect(board.over?).to be(false)
    end
  end
  
  describe '#rows_to_clear' do
    subject(:board) {Board.new}
    
    it 'identifies rows where all squares are full' do
      (0..9).each do |col|
         board[[3, col]], board[[7, col]] = 1, 1
      end
      
      expect(board.rows_to_clear).to eq([3, 7])
    end
  end
  
  describe '#dup_board' do
    subject(:board) {Board.new}
    
    before(:each) do
      board[[0, 3]] = 1
      board[[1, 3]] = 1
      board[[0, 5]] = 1
      board[[1, 5]] = 1
    end
      
    it 'produces a new board object' do 
      dupped_board = board.dup_board
      expect(dupped_board).not_to be(board) 
    end
    
    it 'dupped board has an identical grid' do
      dupped_board = board.dup_board
      expect(dupped_board.grid).to eq(board.grid) 
    end
  end
  
  describe '#clear_row' do
    it 'lowers all locked pieces / squares above the cleared row'
  end
end
  
#   def spawn_piece
#   end
#
#   def line_to_clear?
#   end
#
#   def clear_line
#   end
#
#   def lock_board
#   end
#
#   def lower_piece
#   end
#
#   def num_turns
#   end