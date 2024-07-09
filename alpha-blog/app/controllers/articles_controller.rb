class ArticlesController < ApplicationController
    before_action :set_article, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, only: [:new, :create, :edit, :update]

    


    def index
        @pagy, @articles = pagy(Article.all, items: 10)
    end

    def show
        @article.increment!(:views)

    end

    def new
        @article = Article.new
    end


    def edit 
        authorize @article
    end 

    def create
        @article = Article.new(article_params)
        @article.user = current_user
        if @article.save
            flash[:notice] = "Article was created successfully"
            redirect_article
            # redirect @article (racourci)
        else 
            render 'new', status: :unprocessable_entity
        end
    end

    def update 
        authorize @article
        if @article.update(article_params)
            flash[:notice] = "Article was updated successfully"
            redirect_article
        else 
            render 'edit', status: :unprocessable_entity
        end
    end

    def destroy
        if @article.user != current_user || !current_user.admin?
            flash[:alert] = "You can only delete your own articles"
        else 
            @article.destroy
            flash[:notice] = "Article was successfully deleted"
            redirect_to articles_path
    
        end
    end
    

    private 
    def article_params
        params.require(:article).permit(:title, :description)
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
