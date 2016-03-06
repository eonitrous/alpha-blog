class UsersController < ApplicationController

  # for following actions to be available user must be set
  before_action :set_user, only: [:edit, :update, :show]
  # restrict access to routines to edit other users
  before_action :require_same_user, only: [:edit, :update]

  def index
    # @users = User.all
    # now the above code becomes the following by using paginate gem
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to the alpha blog #{@user.username}"
      redirect_to user_path(@user)
    else
      render 'new'
    end

  end



  def edit

  end

  def update

  # below line was replaced by before action command at top
  #  @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:success] = "Your account was updated successfully"
      redirect_to articles_path
    else
      render 'edit'
    end

  end

  def show
    # below line was replaced by before action command at top
    # @user = User.find(params[:id])
    # add pagination code to show user's articles in a paginated way
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end


  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user
      flash[:danger] = "You can only edit your own account"
      redirect_to root_path
    end
  end

end