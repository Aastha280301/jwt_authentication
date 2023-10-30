require 'csv'

class UsersController < ApplicationController
  before_action :authenticate_request, except: [:create, :new, :new_import_file, :import_users]
  
  def index
    @users = User.all
    render json: @users, status: :ok
  end
  
  def new
    @user = User.new
  end

  def show 
    render json: @user, status: :ok
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render 'create'
    else 
      render json: { errors: @user.errors.full_messages },
      status: :unprocessable_entity
    end
  end

  def new_import_file
  end

  def import_users
    uploaded_file = params[:file]
    UserWorker.perform_async(uploaded_file.path)
    render json: { message: "CSV is successfully import" }
  end

  def update_password
    @user = User.find_by(email: params[:email])

    if @user.authenticate(params[:current_password])
      if @user.update(password: params[:new_password])
        UserMailer.with(user: @user).welcome_email.deliver_now
        render json: { message: "Password updated successfully" }
      else
        render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: "Current password is incorrect" }, status: :unprocessable_entity
    end
  end

  def update
    unless @user.update(user_params)
      render json: { errors: @user.errors.full_messages },
      status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
