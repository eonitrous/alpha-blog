class PagesController < ApplicationController

  def home
    #if user is logged in, do not di,splay home page, redirect to Articles page instead
    redirect_to articles_path if logged_in?
  end

  def about

  end

end