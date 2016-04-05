require 'test_helper'

# Integration test to simulate a whole user action  - here listing categories
class CreateCategoriesTest < ActionDispatch::IntegrationTest

  # set up categories to test
  def setup
    @category = Category.create(name: "books")
    @category2 = Category.create(name: "programming")
  end

  test "should show categories listing" do
    # first get categories path
    get categories_path
    # are we there?
    assert_template 'categories/index'
    # now the author want sto make sure the categories themselves and their links are
    # displayed on page
    assert_select "a[href=?]", category_path(@category), text: @category.name
    assert_select "a[href=?]", category_path(@category2), text: @category2.name

  end


end