class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def index
    @users = User.all
  end

  def upload_pic_get
    @user = current_user
  end

  def upload_pic
    @user = current_user
    @user.image_data = user_image_params

    if @user.save
      flash[:notice] = 'Profile picture was successfully uploaded'
      redirect_to @user
    else
      flash[:alert] = 'Profile picture was not uploaded'
      redirect_to @user
    end
  end

  def show
    @user = current_user
  end

  def user_image_params
    return unless params[:user] && params[:user][:image_data]

    @user.image = params[:user][:image_data] # Assign the uploaded file
  end
end
