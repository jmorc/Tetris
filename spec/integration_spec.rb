require 'game'
require 'rspec'

describe 'Integrated behavior of game' do
  context 'Board creates and manages a tetromino' do
    subject(:board) { Board.new}
    before(:each) { board.spawn_tetromino }
    
    describe 'Board#spawn_tetromino' do
      it 'produces a tetromino as the current_tetromino' do
        expect(board.current_tetromino).to be_a(Tetromino)
      end
        
      it 'produces a tetromino at the correct position' do
        expect(board.current_tetromino.pos).to eq([19, 3])
      end
    end
    
    describe 'Board#lower_tetromino' do
      it 'moves the current tetromino down a step' do
        board.lower_tetromino
        expect(board.current_tetromino.pos).to eq([18,3])
      end
    end

    describe 'Board#valid_pos? knows when a tetromino' do
      it 'is off the board' do
        expect(board.valid_pos?).to eq(false)
      end
      
      it 'has a valid position' do
        4.times { board.lower_tetromino }
        expect(board.valid_pos?).to eq(true)
      end
      
      it 'overlaps a filled position' do
        4.times { board.lower_tetromino }
        board[[17,4]] = 1
        expect(board.valid_pos?).to eq(false)
      end
    end
    
    describe 'Board#valid_locking_pos?' do
      it 'recognizes an invalid locking position' do
        4.times { board.lower_tetromino }
        expect(board.valid_locking_pos?).to eq(false)
      end
      
      it 'recognizes when a tetromino is on the bottom of the grid' do
        21.times { board.lower_tetromino }
        expect(board.valid_locking_pos?).to eq(true)
      end
      
      it 'recognizes a valid locking position on top of other pieces' do
        4.times { board.lower_tetromino }
        board[[16, 4]] = 1
        expect(board.valid_locking_pos?).to eq(true)
      end
    end
    
    describe 'Board#lock_tetromino' do
      before(:each) do
        4.times { board.lower_tetromino }
        board.lock_tetromino
      end
        
      it 'considers the tetromino squares to be filled' do
        should_be_ones = [board[[18, 4]], board[[18, 5]], 
                          board[[17, 4]], board[[17, 5]]]
                          
        expect(should_be_ones.all? { |el| el == 1 }).to eq(true)
      end
      
      it 'sets the current tetromino to nil' do
        expect(board.current_tetromino.nil?).to eq(true)
      end
    end
    
    describe 'Board#tetromino_in_pos? correctly identifies' do
      before(:each) do
        4.times { board.lower_tetromino }
      end

      it 'grid coords containing an active tetromino' do
        expect(board.tetromino_in_pos?([18, 4])).to eq(true)
      end

      it 'grid coords not containing an active tetromino' do
        expect(board.tetromino_in_pos?([13, 4])).to eq(false)
      end
    end
  end
  
  context 'ComputerPlayer plays with a board' do
    subject(:computer_player) { ComputerPlayer.new(Board.new) }
    before(:each) do
      computer_player.board.spawn_tetromino
    end
  
    describe 'ComputerPlayer#optimize_placement' do
      it 'maximizes row clears' do
        (0..7).each do |col|
          computer_player.board[[0, col]] = 1
          computer_player.board[[1, col]] = 1
        end
        expect(computer_player.optimize_target).to eq([-2, 7])
      end
    
      it 'minimizes intra-row transitions (~ gaps in the row)' do
        (2..5).each do |col|
          computer_player.board[[0, col]] = 1
          computer_player.board[[1, col]] = 1
        end
        expect(computer_player.optimize_target).to eq([-2, -1])
      end
    end
  
    describe 'ComputerPlayer#ready_to_drop?' do
      before(:each) do
        computer_player.target_pos = [0, 0]
      end
    
      it 'knows when to drop tetromino' do
        computer_player.board.current_tetromino.pos = [15, 0]
        expect(computer_player.ready_to_drop?).to eq(true)
      end
    
      it 'knows when not to drop tetromino' do
        computer_player.board.current_tetromino.pos = [15, 3]
        expect(computer_player.ready_to_drop?).to eq(false)
      end  
    end
  
    describe 'ComputerPlayer#drop' do
      it 'drops tetromino to the target position' do
        computer_player.drop
        expect(computer_player.tetromino_pos).to eq(computer_player.target_pos)
      end
    end
  
    describe 'ComputerPlayer#step' do
      before(:each) do
        computer_player.target_pos = [0, 4]
      end
    
      it 'moves in the correct direction' do
        computer_player.board.current_tetromino.pos = [15, 3]
        computer_player.step
        expect(computer_player.tetromino_pos).to eq([15, 4])
      end
    
      it "doesn't move an aligned tetromino" do
        computer_player.board.current_tetromino.pos = [15, 4]
        computer_player.step
        expect(computer_player.tetromino_pos).to eq([15, 4])
      end
    
      it 'correctly rotates the tetromino'
    end
  end
  
  context 'Winning and losing games' do
    subject(:game) { Game.new }
    context 'when the board can be played indefinitely' do
      before(:each) { game.play }
    
      it 'plays until max moves is reached' do
        expect(game.moves).to eq(50)
      end
    
      it 'names ComputerPlayer a winner' do
        expect(game.player.status).to eq('winner')
      end
    end
    
    context 'when the board cannot be defeated' do
      before(:each) do
        (0..16).each do |row|
          (1..8).each do |col| 
            game.board[[row, col]] = 1
          end
        end
        game.play
      end
        
      it 'stops playing when the game is over' do
        expect(game.moves).to be < 5
      end
      
      it 'names ComputerPlayer a loser' do
        expect(game.player.status).to eq('loser')
      end
    end
  end
end