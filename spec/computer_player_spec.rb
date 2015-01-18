require 'rspec'
require 'computer_player'


describe ComputerPlayer do
  subject(:computer_player) { ComputerPlayer.new(Board.new) }
  before(:each) do
    computer_player.board.spawn_tetronimo
  end
    
  
  describe '#optimize_placement' do
    it 'maximizes line clears'
    it 'minimizes the height of the stack'
    it 'minimizes gaps'
    it 'decides between equally good moves'
  end
  
  
end

