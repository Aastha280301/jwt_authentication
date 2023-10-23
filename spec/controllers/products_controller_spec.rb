require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  include JsonWebToken 	 

  let(:user) { create(:user) }
  
  before(:each) do
    @token = jwt_encode(user_id: user.id)
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new product' do
        expect do
          order = create(:order, order_detail: "delivered")
          request.headers['Authorization'] = "Bearer #{@token}"
          product = create(:product,user_id: user.id, order_id: order.id, products_name: "ExampleProduct")
        end.to change(Product, :count).by(1)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid parameters' do
      it 'returns unprocessable entity status' do
        request.headers['Authorization'] = "Bearer #{@token}"
        order = create(:order, order_detail: "confirmed")
        post :create, params: { product: { user_id: 1, price: 10.99 } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
