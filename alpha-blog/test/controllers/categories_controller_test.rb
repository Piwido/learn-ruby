require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers
  include ControllerMacros

  setup do
    @category = Category.create(name: 'Sports')
    login_user(self)
  end

  test 'should get index' do
    get :index # Updated from categories_url to :index
    assert_response :success
  end

  test 'should get new' do
    login_admin(self)
    get :new # Updated from new_category_url to :new
    assert_response :success
  end

  test 'should show category' do
    get :show, params: { id: @category.id } # Updated from category_url(@category)
    assert_response :success
  end

  test 'should create category if admin' do
    login_admin(self)
    assert_difference('Category.count', 1) do
      post :create, params: { category: { name: 'Travel' } } # Updated from categories_url
    end
    assert_redirected_to category_path(Category.last)
  end

  test 'should not create category if not admin' do
    assert_no_difference('Category.count') do
      post :create, params: { category: { name: 'Tech' } } # Updated from categories_url
    end
    assert_redirected_to categories_path # Assuming this is your index route
  end
end
