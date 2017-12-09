require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @admin      = users(:patrick)
    @non_admin  = users(:dash)
    @non_activated_user = users(:paws)
  end

  test "index as admin, which includes pagination and delete links" do
    log_in_as(@admin)
    get users_path
    assert_template "users/index"
    assert_select "div.pagination", count: 2
    first_users_page = User.paginate(page: 1)
    first_users_page.each do |user|
      if user == @non_activated_user
        true
      else
        assert_select "a[href=?]", user_path(user), text: user.name
          unless user == @admin
            assert_select "a[href=?]", user_path(user), text: "Delete"
          end
      end
    end
      assert_difference "User.count", -1 do
        delete user_path(@non_admin)
    end
  end

  test "index as non-admin" do
    log_in_as(@non_admin)
    get users_path
    assert_select "a", text: "delete", count: 0
  end

  test "should only show activated users" do
    log_in_as(@non_admin)
    get user_path(@non_activated_user)
    assert_redirected_to login_url
  end
end
