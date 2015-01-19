require 'rspec'
require 'computer_player'


describe ComputerPlayer do
  subject(:computer_player) { ComputerPlayer.new(Board.new) }
  before(:each) do
    computer_player.board.spawn_tetronimo
  end
    
  
  describe '#optimize_placement' do
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
  
  describe '#ready_to_drop?' do
    before(:each) do
      computer_player.target_pos = [0, 0]
    end
    
    it 'knows when to drop tetronimo' do
      computer_player.board.current_tetronimo.pos = [15, 0]
      expect(computer_player.ready_to_drop?).to eq(true)
    end
    
    it 'knows when not to drop tetronimo' do
      computer_player.board.current_tetronimo.pos = [15, 3]
      expect(computer_player.ready_to_drop?).to eq(false)
    end  
  end
  
  describe '#drop' do
    it 'drops tetronimo to the target position' do
      computer_player.drop
      expect(computer_player.tetronimo_pos).to eq(computer_player.target_pos)
    end
  end
  
  describe '#step' do
    before(:each) do
      computer_player.target_pos = [0, 4]
    end
    
    it 'moves in the correct direction' do
      computer_player.board.current_tetronimo.pos = [15, 3]
      computer_player.step
      # expect #step to call move right
      expect(computer_player.tetronimo_pos).to eq([15, 4])
    end
    
    it "doesn't move an aligned tetronimo" do
      computer_player.board.current_tetronimo.pos = [15, 4]
      computer_player.step
      expect(computer_player.tetronimo_pos).to eq([15, 4])
    end
    
    it 'correctly rotates the tetronimo'
  end
end