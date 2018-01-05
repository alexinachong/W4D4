class UsersController < ApplicationController

  before_action :require_logged_out

  def new
    render :new
  end

  def create
    user = User.new(user_params)

    if user.save
      login_user!(user)
    else
      flash.now[:errors] = ["Username and/or password not valid"]
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
