require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase

  def setup
    # set up a test category to be used by test methods
    @category = Category.create(name: "sports")
    # set up a test admin user to be used by test methods
    @user = User.create(username: "john", email: "john@example.com", password: "password", admin: true)
  end


  test "should get categories index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    # simulate a logged in admin user by setting the session id
    session[:user_id] = @user.id
    get :new
    assert_response :success
  end

  test "should get show" do
    get(:show, {'id' => @category.id})
    assert_response :success
  end

  test "should redirect when logged in user is not admin for create action" do
    assert_no_difference 'Category.count' do
      post :create, category: { name: "sports" }
    end
    assert_redirected_to categories_path
  end


end
