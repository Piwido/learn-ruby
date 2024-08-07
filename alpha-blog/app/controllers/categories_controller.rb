class CategoriesController < ApplicationController
  before_action :require_admin, except: %i[index show]

  def new
    @category = Category.new
    response.status = 200
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = 'Category was successfully created'
      redirect_to @category
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:notice] = 'Category name was successfully updated'
      redirect_to @category
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def index
    @q = Category.ransack(params[:q])
    result = @q.result(distinct: true)
    @pagy, @categories = pagy(result, items: 10)
  end

  def show
    @category = Category.find(params[:id])
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin
    return if user_signed_in? && current_user.admin?

    flash[:alert] = 'Only admins can perform that action'
    redirect_to categories_path
  end
end
