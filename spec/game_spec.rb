require 'game'
require 'rspec'

describe Game do
  subject(:game) { Game.new }
  context 'when the board can be played indefinitely' do
    before(:each) { game.play }

    it 'plays until max moves is reached' do
      expect(game.moves).to eq(100)
    end

    it 'names ComputerPlayer a winner' do
      expect(game.player.status).to eq('winner')
    end
  end

  context 'when the board cannot be defeated' do
    before(:each) do
      (1..8).each do |el| 
        game.board[[17, el]] = 1
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