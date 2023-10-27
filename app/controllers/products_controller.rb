class ProductsController < ApplicationController
  before_action :authenticate_request, except: [:index, :create, :new, :show]
  before_action :check_role 

  def index
    @products = Product.paginate(page: params[:page], per_page: 10)
    @products = Product.all
  end

  def new
    @product = Product.new
  end
  
  def create
    @product = Product.new(product_params) 
    if @product.save
      redirect_to products_path
    else 
      render json: { errors: @product.errors.full_messages },
      status: :unprocessable_entity
    end
  end

  def show
    @product = Product.find(params[:id])
  end 

  private

  def product_params
    params.require(:product).permit(:user_id, :products_name, :price, :order_id)
  end

  def check_role
    token = params[:token]
    if token
      payload = jwt_decode(token)
      @current_user_roles = payload['roles']

      if @current_user_roles.include?('admin')
        render 'create'
      else
        redirect_to products_path
      end
    else

    end
  end

end