require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    # get sessions_new_url
    get login_path #update based on how written in routes.rb
    assert_response :success
  end

end
