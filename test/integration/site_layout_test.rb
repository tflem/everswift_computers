require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:patrick)
  end

  test "layout links" do
    get root_path
    assert_template "static_page/home"
    assert_select "a[href=?]", root_path
    assert_select "section#company-introduction"
    assert_select "section#services"
    assert_select "section#products"
    assert_select "section#about"
    get login_path
    get signup_path
    assert_select "title", full_title("Sign Up")
    log_in_as(@user)
    get users_path
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", user_path(@user)
    assert_select "a[href=?]", edit_user_path(@user)
    assert_select "a[href=?]", logout_path
  end
end
