class ArticlesController < ApplicationController

  def new
    @article = Article.new
  end

  def create
    # render plain: params[:article].inspect # inspect what has been passed from article.new form
    @article = Article.new(article_params) #  create instance to hold the values passed from the new article form
    @article.save #save contents of article instance to database table
    redirect_to articles_show(@article)
  end

  private
  def article_params
    params.require(:article).permit(:title, :description)
  end

end
