class ArticlesController < ApplicationController
  include ArticlesHelper
  before_action :require_login, except: [:index, :show]

  def index
    @articles = Article.all
  end
  
  def show
    @article = Article.find(params[:id])
    @comment = Comment.new
    @comment.article_id = @article.id
  end
  
  def new
    @article = Article.new
  end
  
  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = "Article successfully created"
      redirect_to @article
    else
      flash.now[:error] = "Something went wrong"
      render 'new'
    end
  end
  
  def destroy
    @article = Article.find(params[:id])
    @article.destroy ? flash[:notice] = 'Article was successfully deleted.' : flash[:error] = 'Something went wrong'
    redirect_to articles_url
  end
  
  def edit
    @article = Article.find(params[:id])
  end
  
  def update
    @article = Article.find(params[:id])
      if @article.update(article_params)
        flash[:notice] = "Article was successfully updated"
        redirect_to @article
      else
        flash.now[:error] = "Something went wrong"
        render 'edit'
      end
  end
  
end
