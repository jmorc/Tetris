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
    b[[1,1]] = 1
    
    it 'sets a grid position' do
      expect(b.grid[1][1]).to eq(1)
    end
    
    it 'gets a grid position' do
      expect(b[[1,1]]).to eq(1)
    end
  end
  
  describe '#count_stack_height' do
    subject(:board) {Board.new}
    # how to fill some squares on the board?
    
    it 'counts the height of some pieces'
  end
  
  describe 'over?' do
    subject(:board) {Board.new}
    
    it 'knows when the game is over' 
    it 'knows when the game is not over'
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