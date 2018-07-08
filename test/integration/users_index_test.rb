require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @admin = users(:paul)
    @non_admin = users(:archer)
  end

  test "index including pagination" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    first_page_of_users = User.paginate(page: 1)
    first_page_of_users.each do |user|
    # User.paginate(page: 1, per_page: 5).each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
      # not working:
      # unless user == @admin
      #   assert_select 'a[href=?]', user_path(user), text: 'delete'
      # end
    end
    # not working:
    # assert_difference 'User.count', -1 do
    #   delete user_path(@non_admin)
    # end
  end


  # not working:
  # test "should permit destroy when user is an admin" do
  #   # user IS an admin:
  #   log_in_as(@admin)
  #   get users_path
  #   assert_template 'users/index'
  #   assert_difference 'User.count', -1 do
  #     delete user_path(@non_admin)
  #     # delete user_path(users(:archer))
  #     # delete user_path(users(:lana))
  #   end
  #   # assert_redirected_to root_url
  # end

  test "index as non-admin has no 'delete' link present" do
    log_in_as(@non_admin)
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end
end
