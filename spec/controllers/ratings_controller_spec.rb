require 'rails_helper'

RSpec.describe RatingsController, type: :controller do
  let(:user) { create(:user) }
  let(:order) { create (:order)}
  let(:product) { create(:product,user_id: user.id, order_id: order.id, products_name: "ExampleProduct")}

  describe 'GET #new' do
    it 'assigns a new rating to @rating' do
      get :new
      expect(assigns(:rating)).to be_a_new(Rating)
    end
  end

  describe 'POST #create' do
    context 'when user is authenticated' do
      before { allow(controller).to receive(:authenticate_request) { true } }

      it 'creates a new rating' do
        expect do
          post :create, params: { rating: {user_id: user.id, product_id: product.id, rating_value: 5, comment: 'Great product' } }
        end.to change(Rating, :count).by(1)
      end

      it 'renders the create template' do
        post :create, params: { rating: { user_id: user.id, product_id: product.id, rating_value: 5, comment: 'Great product' } }
        expect(response).to render_template('create')
      end
    end

    context 'when user is not authenticated' do
      it 'returns unprocessable entity status' do
        post :create, params: { rating: { product_id: product.id, rating_value: 5, comment: 'Great product' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
