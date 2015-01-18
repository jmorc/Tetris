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
    
    describe '#dup_board' do
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
      it 'clears the row, lowers all pieces' do
        old_board = board.dup_board
        board.clear_row(3)
        expect(old_board.grid[4..19]).to eq(board.grid[3..18])
      end
    end
  end
  
  context 'With tetronimo' do
    subject(:board) { Board.new}
    before(:each) { board.spawn_tetronimo }
   # let(:tetronimo) { double('tetronimo', :cost => 5.99) }
    
    describe '#spawn_tetronimo' do
      it 'produces a tetronimo as the current_tetronimo' do
        expect(board.current_tetronimo).to be_a(Tetronimo)
      end
        
      it 'produces a tetronimo at the correct position' do
        expect(board.current_tetronimo.pos).to eq([19, 3])
      end
    end
    
    describe '#lower_tetronimo' do
      it 'moves the current tetronimo down a step' do
        board.lower_tetronimo
        expect(board.current_tetronimo.pos).to eq([18,3])
      end
    end
    
    describe '#track_tetronimo' do
      it 'knows where the tetronimo is on the board' do
        4.times { board.lower_tetronimo }
        board.track_tetronimo
        should_be_T = [board[[17, 4]], board[[17, 5]], 
                       board[[18, 4]], board[[18, 5]]]
        expect(should_be_T.all? { |el| el == "T"}).to eq(true)
      end
    end
    
    describe '#valid_position? knows when a tetronimo' do
      it 'is off the board' do
        expect(board.valid_position?).to eq(false)
      end
      
      it 'has a valid position' do
        4.times { board.lower_tetronimo }
        expect(board.valid_position?).to eq(true)
      end
      
      it 'overlaps a filled position' do
        4.times { board.lower_tetronimo }
        board[[17,4]] = 1
        expect(board.valid_position?).to eq(false)
      end
    end
    
    describe '#valid_locking_position?' do
      it 'recognizes an invalid locking position' do
        4.times { board.lower_tetronimo }
        expect(board.valid_locking_position?).to eq(false)
      end
      
      it 'recognizes when a tetronimo is on the bottom of the grid' do
        21.times { board.lower_tetronimo }
        expect(board.valid_locking_position?).to eq(true)
      end
      
      it 'recognizes a valid locking position on top of other pieces' do
        4.times { board.lower_tetronimo }
        board[[16, 4]] = 1
        expect(board.valid_locking_position?).to eq(true)
      end
      
    end
    
    describe '#lock_tetronimo' do
      it 'considers the tetronimo squares to be filled'
      it 'eliminates the current tetronimo'
    end
  
  end
end
  
#   def spawn_piece
#   end

#   def lower_piece
#   end
#
#   def num_turns
#   end