class ArticlesController < ApplicationController

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end


  def create
    # render plain: params[:article].inspect # inspect what has been passed from article.new form
    @article = Article.new(article_params) #  create instance to hold the values passed from the new article form
    #@article.save #save contents of article instance to database table

    # Correct way of doing a save from a form is supposedly be given below
    # This instructor is a mess
    if @article.save # if save was successful
      #do something
      flash[:notice] = "Article was successfully created"
      redirect_to article_path(@article)
    else # an error occurred during save
      render 'new' #instructor simply wants to display the form again
    end

  end

  def update

    @article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:notice] = "Article was successfully updated"
      redirect_to article_path(@article)
    else
      render 'edit'
    end

  end



  def show
    @article = Article.find(params[:id])
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    flash[:notice] = "Article was successfully deleted"
    redirect_to articles_path
  end



  private
  def article_params
    params.require(:article).permit(:title, :description)
  end

end
