require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  include JsonWebToken 	 

  let(:user) { create(:user) }

  before(:each) do
    @token = jwt_encode(user_id: user.id)
  end

  describe "GET #search" do
    it "returns a JSON order if a valid product is found" do
      order = create(:order, order_detail: "delivered")
      product = create(:product,user_id: user.id, order_id: order.id, products_name: "ExampleProduct")
      request.headers['Authorization'] = "Bearer #{@token}"
      get :search, params: { search_product: "ExampleProduct" }
      expect(response).to have_http_status(:success)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['id']).to eq(order.id)
    end

    it "returns a JSON order if a valid user is found" do
      order = create(:order, order_detail: "delivered")
      product = create(:product,user_id: user.id, order_id: order.id, products_name: "ExampleProduct")
      request.headers['Authorization'] = "Bearer #{@token}"
      get :search, params: { search_user: user.id }
      expect(response).to have_http_status(:success)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['id']).to eq(order.id)
    end

    it "returns an error message if no valid information is provided" do
      request.headers['Authorization'] = "Bearer #{@token}"
      get :search
      expect(response).to have_http_status(:success)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['errors']).to eq("Enter valid information")
    end
  end
end
