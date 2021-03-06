class Api::ArticlesController < ApplicationController

  before_action :ensure_logged_in, except: [:index, :show]

  def show
    @article = Article.find(params[:id])
    if @article && (@article.published || @article.author = current_user)
      render :show
    end
  end

  def create
    @article = Article.new(author_id: current_user.id, title: "")
    Chunk.create(ord: 0, content_type: 'p', article: @article, content: '')
    @article.save
    render :show
  end

  def update
    @article = current_user.articles.find(params[:id])
    if @article && @article.update(article_params)
      render :show
    else
      render @article.errors.full_messages
    end
  end

  def index
    if logged_in?
      @articles = Article.logged_in_index_articles(current_user)
      render :index
    else
      @articles = Article.logged_out_index_articles
      render :index
    end
  end

  def destroy
    @article = current_user.articles.find(params[:id])
    @article.destroy if @article
  end

  def like
    @article = Article.find(params[:id])
    @article.likers << current_user if @article
  end

  def unlike
    @article = Article.find(params[:id])
    @article.likers.delete(current_user) if @article
  end

  def manage
    @articles = current_user.articles.order(created_at: :desc)
    render :manage
  end

  private

  def article_params
    params.require(:article).permit(
      :id,
      :title,
      :publish_date,
      :author_id,
      :published,
      chunks_attributes: [
        :content,
        :ord,
        :content_type,
        :id,
        :chunkable_id,
        :image,
        :youtube_url
      ]
    )
  end
end
