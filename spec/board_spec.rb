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
  
  context 'With a partly-filled board' do
    subject(:board) {Board.new}
    
    before(:each) do
      # fill a column of the board so that the game is over
      (0..19).each do |row|
        board[[row, 0]] = 1
      end
      
      # fill a few rows of the board so they can be recognized and cleared
      (0..9).each do |col|
        board[[3, col]] = 1
        board[[7, col]] = 1
      end
    end
    
    describe '#count_stack_height' do
      it 'counts the height of filled squares' do
        expect(board.count_stack_height).to eq(20)
      end
    end
    
    describe '#count_intrarow_transitions' do
      it 'counts the intrarow transitions (these are ~ gaps)' do
        expect(board.count_intrarow_transitions).to eq(18)
      end
    end
    
    describe '#over?' do
      it 'can tell when the game is over' do
        expect(board.over?).to be(true)
      end
    
      it 'can tell when the game is not over' do
        board[[19, 0]] = 0
        expect(board.over?).to be(false)
      end
    end
    
    describe '#rows_to_clear' do
      it 'identifies rows where all squares are full' do
        expect(board.rows_to_clear).to eq([3, 7])
      end
    end
    
    describe '#clear_row' do
      it 'clears the row, lowers all pieces' do
        old_board = board.dup_board
        board.clear_row(3)
        expect(old_board.grid[4..19]).to eq(board.grid[3..18])
      end
    end
    
    describe '#sweep_rows' do
      it 'clears all the full rows' do
        board.sweep_rows
        expect(board.rows_to_clear.empty?).to eq(true)
      end
    end
    
    describe '#dup_board' do
      it 'produces a new board object' do 
        dupped_board = board.dup_board
        expect(dupped_board).not_to be(board) 
      end
    
      it 'dupped board has an identical grid' do
        dupped_board = board.dup_board
        expect(dupped_board.grid).to eq(board.grid) 
      end
      
      it 'dupped grid is a distinct object' do
        dupped_board = board.dup_board
        expect(dupped_board.grid).not_to be(board.grid) 
      end
    end
  end
end