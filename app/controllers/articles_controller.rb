class ArticlesController < ApplicationController

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
    render 'new' #but this is implicit
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create

    @article = Article.new(article_params)

    if not unique
      @article.errors.add(:title, :not_unique, message: "already in use!")
      render 'new'
      return
    end

    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  private
  def article_params
    params.require(:article).permit(:title, :text)
  end

  def unique
    if (Article.where(:title => @article.title)) == nil
      return true
    end
    return false
  end

end
