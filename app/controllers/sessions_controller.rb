class SessionsController < ApplicationController

  # new session
  def new

  end

  #create session
  def create
    #    find user and if exists, compare the password to authenticate
    user = User.find_by(email: params[:session][:email].downcase)

    if user && user.authenticate(params[:session][:password])
      # to save the session information to be saved and used by browser cookies
      # so that logged in users can be separated from not logged in users
      session[:user_id] = user.id

      flash[:success] = "You have successfully logged in"
      redirect_to user_path(user)
    else
      flash.now[:danger] = "User information does not match records"
      render 'new'
    end

  end

  #destroy session
  def destroy
    # set user_id to nil so that it appears as not logged in to the browser
    session[:user_id] = nil
    flash[:success] = "You have logged out"
    redirect_to root_path
  end


end
