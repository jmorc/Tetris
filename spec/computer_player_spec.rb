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
      expect(computer_player.optimize_placement).to eq([-2, 7])
    end
    
    it 'minimizes the height of the stack'
    it 'minimizes gaps'
    it 'decides between equally good moves'
  end
  
  
end

