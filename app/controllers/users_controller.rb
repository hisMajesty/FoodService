class UsersController < ApplicationController
  def index
    @users = User.all
    @user = User.new
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit(:login, :password, :password_confirmation))
    if @user.save
      redirect_to users_path
    else
      redirect_to user_path, :notice => 'Error'
    end
  end

  def list
    @users = User.all
  end

end
