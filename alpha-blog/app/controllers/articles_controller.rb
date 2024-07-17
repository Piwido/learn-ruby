# frozen_string_literal: false

# Articles controller
class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]
  before_action :authenticate_user!, only: %i[new create edit update]

  def index
    @q = Article.ransack(params[:q])
    @articles = @q.result.includes(:categories).distinct.page(params[:page])

    @pagy, @articles = pagy(@articles, items: 10)
  end

  def show
    @article.increment!(:views)
  end

  def new
    @article = Article.new
  end

  # bypasser la rediction de la police
  def edit
    if authorize @article
      render 'edit'
    else
      flash[:alert] = 'You can only edit your own articles'
      redirect_articles
    end
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:notice] = 'Article was created successfully'
      redirect_article
    # redirect @article (racourci)
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def update
    if (authorize @article) && @article.update(article_params)
      flash[:notice] = 'Article was updated successfully'
      redirect_article
    else
      redirect_articles
    end
  end

  def destroy
    if !current_user || (@article.user != current_user && !current_user.admin?)
      flash[:alert] = 'You can only delete your own articles'
      redirect_articles
    else
      @article.destroy
      flash[:notice] = 'Article was successfully deleted'
      redirect_articles
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :description, category_ids: [])
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def redirect_article
    redirect_to article_path(@article)
  end

  def redirect_articles
    redirect_to articles_path
  end
end
