class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def index
    @users = User.all

    @q = User.ransack(params[:q])
    result = @q.result(distinct: true)
    @users = result
  end

  def upload_pic_get
    @user = current_user
  end

  def upload_pic_post
    @user = current_user

    unless params[:photo] && params[:photo][:image]
      flash[:alert] = 'No image provided'
      redirect_to upload_pic_get_path
      return
    end

    @user.photo.attach(params[:photo][:image])

    if @user.save
      flash[:notice] = 'Profile picture was successfully uploaded'
      redirect_to user_path(@user)
    else
      flash[:alert] = 'Profile picture was not uploaded'
      render 'upload_pic_get', status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def user_image_params
    return unless params[:user] && params[:user][:image_data]

    @user.image = params[:user][:image_data] # Assign the uploaded file
  end
end
