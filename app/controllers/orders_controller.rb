class OrdersController < ApplicationController

  def search
    @search_product = params[:search_product]
    @search_user = params[:search_user]

    order_data = Product.find_by(products_name: "#{@search_product}") || Product.find_by(user_id:  "#{@search_user}")

    if order_data
      order = Order.find_by(id: order_data.order_id)
      render json: order
    else
      render json: { errors: "Enter valid information"}
    end
  end

end