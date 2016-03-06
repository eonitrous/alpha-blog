class ArticlesController < ApplicationController

  before_action :set_article, only: [:edit, :update, :show, :destroy]
  # add access restriction based on logged in user except for index and show actions
  before_action :require_user, except: [:index, :show]
  # As loggd in users can edit and delete other's articles by manually  browsng to
  # articles, the instructor is adding another before action here.
  before_action :require_same_user, only: [:edit, :update, :destroy]


  def index
#    @articles = Article.all
    # now the above code becomes the following by using paginate gem
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def new
    @article = Article.new
  end

  def edit
    # below line was replaced by before action command at top
    # @article = Article.find(params[:id])
  end


  def create
    # render plain: params[:article].inspect # inspect what has been passed from article.new form

    #to use the debugger byebug gem
    #debugger

    @article = Article.new(article_params) #  create instance to hold the values passed from the new article form
   # @article.save #save contents of article instance to database table

    # temporarily hard coded user selection for articles table until the authentication part is done
    # @article.user = User.first
    # authentication done, now add working user selection code
    @article.user = current_user

    # Correct way of doing a save from a form is supposedly be given below
    # This instructor is a mess
    if @article.save # if save was successful
      #do something
      flash[:success] = "Article was successfully created"
      redirect_to article_path(@article)
    else # an error occurred during save
      render 'new' #instructor simply wants to display the form again
    end

  end

  def update
# below line was replaced by before action command at top
#    @article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:success] = "Article was successfully updated"
      redirect_to article_path(@article)
    else
      render 'edit'
    end

  end



  def show
 # below line was replaced by before action command at top
 #   @article = Article.find(params[:id])
  end

  def destroy
  # below line was replaced by before action command at top
  #  @article = Article.find(params[:id])

    @article.destroy
    flash[:danger] = "Article was successfully deleted"
    redirect_to articles_path
  end



  private
  def article_params
    params.require(:article).permit(:title, :description)
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def require_same_user
    # current_user is initialized by require_user
    # @article.user is initialized by set_article
    # so we can use both of these already available instance variables
    if current_user != @article.user and !current_user.admin?
      flash[:danger] = "You can only edit or delete your own articles"
      redirect_to root_path
    end
  end


end
