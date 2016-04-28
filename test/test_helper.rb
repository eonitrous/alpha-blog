ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  # add sign_in_as method to be used by methods in create_categories_test.rb
  def sign_in_as(user, password)
    # login page expects user e-mail and password to be entered in the form
    #so post to login_path with parameters to open a session
    # email is retrieved from user instance, but password is passed directly to the method by from the calling method
    # just like a user would enter his password from the login screen
    post login_path, session: {email: user.email, password: password}
  
  end

end
