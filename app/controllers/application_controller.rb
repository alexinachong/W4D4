class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def current_user
    return nil unless session[:session_token]
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def login_user!(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
    redirect_to cats_url
  end

  def require_logged_out
    redirect_to cats_url if logged_in?
  end

  def logged_in?
    return false unless current_user
    true
  end

  def owns_cat
    redirect_to cats_url unless current_user == Cat.find_by(id: params[:id]).owner
  end

  def validate_cat_owner
    kitty = CatRentalRequest.find_by(id: params[:id]).cat
    redirect_to cats_url unless current_user == kitty.owner
  end
end
