class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  def current_user_admin
    if current_user
      return current_user.admin
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_user
    unless current_user || current_user_admin
      flash[:notice] = "Please login!"
      redirect_to root_url
      return false
    end
  end

  def avatar_url(user)
    if user.image
      return user.image
    else
      gravatar_id = Digest::MD5.hexdigest(user.email)
      "http://gravatar.com/avatar/#{gravatar_id}.png?s=50"
    end
  end
  helper_method :current_user, :current_user_admin, :require_user, :avatar_url
end
