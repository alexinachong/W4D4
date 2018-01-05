class SessionsController < ApplicationController

  before_action :require_logged_out, except: [:destroy]

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(params[:username], params[:password])
    if user
      login_user!(user)
    else
      flash.now[:errors] = ["Username or password incorrect."]
      render :new
    end
  end

  def destroy
    if current_user
      current_user.reset_session_token!
      session.delete(:session_token)
    end
    redirect_to cats_url
  end
end
