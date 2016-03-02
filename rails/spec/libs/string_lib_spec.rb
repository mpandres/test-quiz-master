require 'rails_helper'

RSpec.describe String do

  describe 'simplify' do
    it 'trims whitespace' do
      expect("  the  moon and the    stars   ".simplify).to eq "the moon and the stars"
    end

    it 'converts word to lowercase' do
      expect("cApiTaliSm".simplify).to eq "capitalism"
    end
  end

  describe 'to_word' do
    it 'converts string integers to its equivalent word' do
      expect("6".to_word).to eq "six"
    end

    it 'retains non-string integers as is' do
      expect("six".to_word).to eq "six"
    end
  end

end
