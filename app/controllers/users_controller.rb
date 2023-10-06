require 'csv'

class UsersController < ApplicationController
  skip_before_action :authenticate_request
  # before_action :authenticate_request, except: [:create]
  before_action :set_user, only: [:show, :destroy]
  
  def index
    @users = User.all
    render json: @users, status: :ok
  end

  def show 
    render json: @user, status: :ok
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else 
      render json: { errors: @user.errors.full_messages },
      status: :unprocessable_entity
    end
  end

  def import_users
    uploaded_file = params[:file]
    UserWorker.perform_async(uploaded_file.path)
    render json: { message: "CSV is successfully import" }
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
    params.permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
