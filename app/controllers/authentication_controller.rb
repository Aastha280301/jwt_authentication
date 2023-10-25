class AuthenticationController < ApplicationController
  before_action :authenticate_request , except: [:login, :index]
  
  def index
  end

  def login
    @user = User.find_by_email(params[:email])
    if @user&.authenticate(params[:password])
      user_roles = @user.roles.pluck(:name)
      @token = jwt_encode(user_id: @user.id, roles: user_roles)
      redirect_to products_path(token: @token)
      # redirect_to check_role_path(current_user: @current_user)
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

end
