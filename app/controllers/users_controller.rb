class UsersController < ApplicationController

  def index

  end

  def show
    @user = User.find(params[:id])

  end

  def new

  end

  def edit

  end

  def create
    @user = User.new(user_params)
    @user.access_token = 277
    if @user.save
      redirect_to @user
    end
  end

  def update

  end

  private
    def user_params
      params.require(:new_user).permit(:username, :password)
    end

end
