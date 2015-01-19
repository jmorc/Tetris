require 'rspec'
require 'tetromino'

describe Tetromino do
  subject(:tetromino) { Tetromino.new(Tetromino::O_TETROMINO[0]) }
  describe '#dup_tetromino' do
    let(:dup) {tetromino.dup_tetromino}
    
    it 'returns a distinct object' do 
      expect(dup).not_to be(tetromino) 
    end
    
    it 'returns a tetromino object' do
      expect(dup).to be_a(Tetromino)
    end

    it 'new tetromino has the same shape' do
      expect(dup.shape).to eq(tetromino.shape)
    end
    
    it 'new tetromino has a distinct copy of the shape' do
      expect(dup.shape).not_to be(tetromino.shape)
    end
    
    it 'new tetromino has the same position' do
      expect(dup.pos).to eq(tetromino.pos)
    end
    
    it 'new tetromino has a distinct copy of the position' do
      expect(dup.pos).not_to be(tetromino.pos)
    end
    
    it 'new tetromino has the same orientation' do
      expect(dup.orientation).to eq(tetromino.orientation)
    end
  end
end