require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'validations' do
    it 'validates the format of email' do
      user = User.new(email: 'user@example.com', password: 'password')
      expect(user).to be_valid
    end

    it 'does not validate an invalid email format' do
      user = User.new(email: 'invalid-email', password: 'password')
      expect(user).to_not be_valid
    end
  end
 
  describe 'has_secure_password' do
    let(:user) { User.new(email: 'user@example.com', password: 'password') }

    it 'should set and authenticate password' do
      expect(user.password_digest).to_not be_nil
      expect(user.authenticate('password')).to eq(user)
      expect(user.authenticate('wrong_password')).to be false
    end
  end
end
