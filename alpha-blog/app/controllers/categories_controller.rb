class CategoriesController < ApplicationController
    before_action :require_admin, except: [:index, :show]

    def new
      @category = Category.new
    end
  
    def create
      @category = Category.new(category_params)
      if @category.save
        flash[:notice] = "Category was successfully created"
        redirect_to @category
      else
        render 'new', status: :unprocessable_entity
      end
    end
  
    def index
        @pagy, @categories = pagy(Category.all, items: 3)
    end
  
    def show
        @category = Category.find(params[:id])
    end
    
    private
  
    def category_params
      params.require(:category).permit(:name)
    end

    def require_admin
        if !(user_signed_in? && current_user.admin?)
            flash[:alert] = "Only admins can perform that action"
            redirect_to categories_path
        end
    end
  end