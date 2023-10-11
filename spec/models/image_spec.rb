
require 'rails_helper'

RSpec.describe Image, type: :model do
  describe 'Associations' do
    it 'belongs to imageable polymorphically' do
      expect(Image.reflect_on_association(:imageable).macro).to eq :belongs_to
      expect(Image.reflect_on_association(:imageable).options[:polymorphic]).to be true
    end
  end
end
