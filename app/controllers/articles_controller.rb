class ArticlesController < ApplicationController
  before_action :require_access_token
  skip_before_action :verify_authenticity_token

  def index

    @articles = Article.all

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @articles }
    end

  end

  def show
    @article = Article.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json:@article }
    end

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

    if @article.save
      respond_to do |format|
        format.html {
          redirect_to @article
        }
        format.json {render :json => {"Message" => "Why not."}, :status => 201}
      end
    else
      respond_to do |format|
        format.html {
          render 'new'
        }
        format.json {render :json => {:errors => @article.errors.full_messages }, :status => 409}
      end
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

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

  private

  def require_access_token
      if request.format == 'json'
        unless request.headers["access-token"] == "AHU-69-27"
          render json: {}, status: 401
        end
      end
  end

  def article_params
    params.require(:article).permit(:title, :text)
  end


end
