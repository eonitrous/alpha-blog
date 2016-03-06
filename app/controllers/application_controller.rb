class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #methods to work with authenticated and logged in users
  # make these methods helpers to have them available and usable in views
  helper_method :current_user, :logged_in?

  def current_user
    #if current_user is already retrtieved from database, use it. If not, then retrieve
    # the user information bu using user_id paramater of session object
    @current_user ||= User.find(session[:user_id]) if session[:user_id]

  end

  def logged_in?
    #if there is a current_user, then that means he is logged in
    !!current_user

  end

  def require_user
  # for some actions we will require the user to be logged in
    if !logged_in?
      flash[:danger] = "You must be logged in to perform this action"
      redirect_to root_path 
    end
    
  end




end
