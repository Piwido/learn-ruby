class ArticlesController < ApplicationController
    before_action :set_article, only: [:show, :edit, :update, :destroy]
    


    def index
        @articles = Article.all
    end

    def show
    end

    def new
        @article = Article.new
    end


    def edit 
    end 
    def create
        @article = Article.new(article_params)
        @article.user = User.last
        if @article.save
            flash[:notice] = "Article was created successfully"
            redirect_article
            # redirect @article (racourci)
        else 
            render 'new', status: :unprocessable_entity
        end
    end

    def update 
        if @article.update(article_params)
            flash[:notice] = "Article was updated successfully"
            redirect_article
        else 
            render 'edit', status: :unprocessable_entity
        end

    end

    def destroy
        @article.destroy
        flash[:notice] = "Article was successfully deleted"
        redirect_to articles_path
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
