
require 'rails_helper'

RSpec.describe Image, type: :model do
  describe 'Associations' do
    it "has a polymorphic relationship" do
      expect(subject).to belong_to(:imageable)
    end
  end
end