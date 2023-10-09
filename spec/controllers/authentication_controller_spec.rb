require 'rails_helper'

RSpec.describe AuthenticationController, type: :controller do
  let(:user) { create(:user, email: 'test@example.com', password: 'password') }

  describe 'POST #login' do
    context 'with valid credentials' do
      it 'returns a JWT token' do
        post :login, params: { email: user.email, password: 'password' }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to have_key('token')
      end
    end

    context 'with invalid credentials' do
      it 'returns unauthorized' do
        post :login, params: { email: user.email, password: 'invalid_password' }
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)).to have_key('error')
      end

      it 'returns unauthorized for non-existent user' do
        post :login, params: { email: 'nonexistent@example.com', password: 'password' }
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)).to have_key('error')
      end
    end
  end
end
