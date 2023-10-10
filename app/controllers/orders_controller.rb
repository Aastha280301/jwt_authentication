class OrdersController < ApplicationController
  def search
    @search_product = params[:search_product]
    @search_user = params[:search_user]

    product = Product.find_by(products_name: "#{@search_product}")
    user = Product.find_by(user_id: "#{@search_user}")
    
    if product
      order = Order.find_by(id: product.order_id)
      render json: order
    elsif user
      order = Order.find_by(id: user.order_id)
      render json: order
    else
      render json: { errors: "Enter valid information"}
    end

  end
end
