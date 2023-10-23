require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  include JsonWebToken 	 

  let(:user) { create(:user) }

  before(:each) do
    @token = jwt_encode(user_id: user.id)
  end

  # describe 'GET #index' do
  #   it 'returns a list of users' do
  #     request.headers['Authorization'] = "Bearer #{@token}"
  #     get :index
  #     expect(response).to have_http_status(:ok)
  #   end
  # end

  # describe 'GET #show' do
  #   it 'returns the requested user' do
  #     request.headers['Authorization'] = "Bearer #{@token}"
  #     get :show, params: { id: user.id }
  #     expect(response).to have_http_status(:ok)
  #   end
  # end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new user' do
        user_params = {
          user: {
            username: 'test',
            email: 'test@example.com',
            password: '123456'
          }
        }
        post :create, params: user_params
        expect(response).to have_http_status(200)
      end
    end

    context 'with invalid attributes' do
      it 'returns unprocessable entity status' do
        invalid_params = {
          user: {
            username: '', 
            email: 'invalid-email',
            password: 'short' 
          }
        }
        post :create, params: invalid_params

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  # describe 'DELETE #destroy' do
  #   it 'destroys the user' do
  #     request.headers['Authorization'] = "Bearer #{@token}"
  #     expect { delete :destroy, params: { id: user.id } }.to change(User, :count).by(-1)
  #     expect(response).to have_http_status(:no_content)
  #   end
  # end

end
