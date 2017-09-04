require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:patrick)
  end
  
  test "unsuccessful edit" do
    get edit_user_path(@user)
    assert_template "users/edit"
    patch user_path(@user), params: { user: { name:  "",
                                              email: "user@invalid",
                                              password:              "fuu",
                                              password_confirmation: "burr" } }
    assert_template "users/edit"
    assert_select "div.alert", text: "The form has 4 errors."
  end

  test "successful edit" do
    get edit_user_path(@user)
    assert_template "users/edit"
    name  = "Dash McFlash"
    email = "dash@ff.com"
    patch user_path(@user), params: { user: { name:  name,
                                              email: email,
                                              password:              "",
                                              password_confirmation: ""   } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email
  end
end
