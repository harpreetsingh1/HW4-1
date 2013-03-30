require 'spec_helper'

  describe Movie do
  
    describe 'searching same director' do
    it 'should call Movie with director' do
      Movie.should_receive(:same_director).with('Star Wars')
      Movie.same_director('Star Wars')
    end
  end

end
