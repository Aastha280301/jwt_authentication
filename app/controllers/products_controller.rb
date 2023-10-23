class ProductsController < ApplicationController
  before_action :authenticate_request, except: [:index, :create, :new]

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end
  
  def create
    @product = Product.new(product_params) 
    if @product.save
      render 'create'
    else 
      render json: { errors: @product.errors.full_messages },
      status: :unprocessable_entity
    end
  end

  private

  def product_params
    params.require(:product).permit(:user_id, :products_name, :price, :order_id)
  end

end