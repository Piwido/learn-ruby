require "test_helper"

class CreateCategoryTest < ActionDispatch::IntegrationTest
  include Devise::Test::ControllerHelpers
  include ControllerMacros

  
  test "get new category form and create category if admin" do
    login_admin(self)
    get "/categories/new"
    assert_response :redirect
    assert_difference 'Category.count', 1 do 
      post categories_path, params: {category: { name: "Sports"}}
      assert_response :redirect
    end
    follow_redirect!
    assert_response :redirect
    assert_match "Sports", response.body
  end 

  test "get new category form and reject invalid category submission" do
    get "/categories/new"
    assert_response :redirect
    assert_no_difference 'Category.count' do 
      post categories_path, params: {category: { name: "o"}}
    end
    assert_match 'errors', response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  end 

end
