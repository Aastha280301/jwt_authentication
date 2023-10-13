class ProductsController < ApplicationController

  def create
    @product = Product.new(product_params) 
    if @product.save
      render json: @product, status: :created
    else 
      render json: { errors: @product.errors.full_messages },
      status: :unprocessable_entity
    end
  end

  private

  def product_params
    params.permit(:user_id, :products_name, :price, :order_id)
  end

end
