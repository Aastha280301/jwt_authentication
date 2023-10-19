class OrdersController < ApplicationController
  before_action :authenticate_request ,except: [:create, :new]
  
  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params) 
    if @order.save
      redirect_to new_product_path
    else 
      render 'new'
    end
  end

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

  private

  def order_params
    params.require(:order).permit(:order_detail)
  end

end