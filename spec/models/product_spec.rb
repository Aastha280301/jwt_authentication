
require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:images) }
    it { should belong_to(:order) }
  end
end
