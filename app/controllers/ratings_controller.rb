class RatingsController < ApplicationController
  before_action :authenticate_request, except: [:create, :new]

  def index
    @rating = @product.rating.all
  end
  
  def new 
    @rating = Rating.new
  end

  def create
    @product = Product.find_by(params[:id])
    @rating = @product.ratings.new(rating_params)
    current_user = @rating.user  

    if @rating.save
      render 'create'
    else
      render json: { errors: @rating.errors.full_messages },
      status: :unprocessable_entity
    end
  end

  private

  def rating_params
    params.require(:rating).permit(:product_id, :rating_value, :comment, :user_id)
  end
end
