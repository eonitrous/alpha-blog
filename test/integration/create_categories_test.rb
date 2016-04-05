require 'test_helper'

# Integration test to simulate a whole user action  - here creating categories
class CreateCategoriesTest < ActionDispatch::IntegrationTest

  test "get new category form and create category" do

    get new_category_path
    # Can we get new  category form ?
    assert_template 'categories/new'

    # Can we add a new category from new category form ?
    # Here the instructor checks whether the category count has increaed by one after creating a new category
    assert_difference 'Category.count', 1 do
      post_via_redirect categories_path, category: {name: "sports"}
    end
    # can we redirect the user after creating the category ? Here we want to display
    # index page for categories
    assert_template 'categories/index'
    # Now, there should be the new category displayed on the index page. Check if the
    # body of the displayed page contains the word "sports"
    assert_match "sports", response.body

  end

  #test when a category should not be created
  test "invalid category submisson results in failure" do

    get new_category_path
    # Can we get new  category form ?
    assert_template 'categories/new'

    # Can we add a new category from new category form ?
    # Here the instructor checks whether the category count has not been increaed after attemptimng to create a new category
    assert_no_difference 'Category.count' do
      post categories_path, category: {name: " "}
    end
    # can we direct the user after not creating the category ? Here we want to display
    #new page for categories
    assert_template 'categories/new'
    # Now, there should be an error message displayed. Instrutor checks whether CSS elements
    # of error message are contained in the displayed page.
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'



  end

end

