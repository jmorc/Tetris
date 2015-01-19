require 'rspec'
require 'tetronimo'

describe Tetronimo do
  subject(:tetronimo) { Tetronimo.new(Tetronimo::O_TETRONIMO[0]) }
  describe '#dup_tetronimo' do
    let(:dup) {tetronimo.dup_tetronimo}
    
    it 'returns a distinct object' do 
      expect(dup).not_to be(tetronimo) 
    end
    
    it 'returns a tetronimo object' do
      expect(dup).to be_a(Tetronimo)
    end

    it 'new tetronimo has the same shape' do
      expect(dup.shape).to eq(tetronimo.shape)
    end
    
    it 'new tetronimo has a distinct copy of the shape' do
      expect(dup.shape).not_to be(tetronimo.shape)
    end
    
    it 'new tetronimo has the same position' do
      expect(dup.pos).to eq(tetronimo.pos)
    end
    
    it 'new tetronimo has a distinct copy of the position' do
      expect(dup.pos).not_to be(tetronimo.pos)
    end
    
    it 'new tetronimo has the same orientation' do
      expect(dup.orientation).to eq(tetronimo.orientation)
    end
  end
end
