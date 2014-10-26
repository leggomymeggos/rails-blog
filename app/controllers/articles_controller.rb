class ArticlesController < ApplicationController
  http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]

  def index
    @articles = Article.all    
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params) # using params[:article] raises a security error in Rails, so we use this way instead

    if @article.save        # There may be a reason the guide directs us to use #new => #save rather than #create - don't get ahead of yourself
      redirect_to @article  # !!! SUPER NEW => This means redirect to the show action (erb :show, basically, though this is RAILS so it looks a little different)
    else
      render 'new'
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render "edit"
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :text) # #permit allows both :title and :text
  end
end
