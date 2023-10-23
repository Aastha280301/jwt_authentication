
require 'rails_helper'

RSpec.describe Rating, type: :model do
  describe 'associations' do
    it { should belong_to(:user) } 
    it { should belong_to(:product) }
  end
end