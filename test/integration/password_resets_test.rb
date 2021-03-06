require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
    @user = users(:patrick)
  end

  test "password resets" do
    get new_password_reset_path
    assert_template "password_resets/new"
    # Invalid Email
    post password_resets_path, params: { password_reset: { email: ""} }
    assert_not flash.empty?
    assert_template "password_resets/new"
    # Valid Email
    post password_resets_path,
         params: { password_reset: { email: @user.email } }
    assert_not_equal @user.reset_digest, @user.reload.reset_digest
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not flash.empty?
    assert_redirected_to login_url
    # Password Reset Form
    user = assigns(:user)
    # Wrong Email
    get edit_password_reset_path(user.reset_token, email: "")
    assert_redirected_to login_url
    # Inactive User
    user.toggle!(:activated)
    get edit_password_reset_path(user.reset_token, email: user.email)
    assert_redirected_to login_url
    user.toggle!(:activated)
    # Right Email, Wrong Token
    get edit_password_reset_path("wrong token", email: user.email)
    assert_redirected_to login_url
    # Right Email, Right Token
    get edit_password_reset_path(user.reset_token, email: user.email)
    assert_template "password_resets/edit"
    assert_select "input[name=email][type=hidden][value=?]", user.email
    # Invalid Password and Confirmation
    patch password_reset_path(user.reset_token),
          params: { email: user.email,
                    user: { password:              "fuubazzle",
                            password_confirmation: "bargonnee" } }
    assert_select "div#error_explanation"
    # Empty Password
    patch password_reset_path(user.reset_token),
          params: { email: user.email,
                    user: { password:              "",
                            password_confirmation: "" } }
    assert_select "div#error_explanation"
    # Valid Password and Confirmation
    patch password_reset_path(user.reset_token),
          params: { email: user.email,
                    user: { password:              "foobazzle",
                            password_confirmation: "foobazzle" } }
    assert is_logged_in?
    assert_not flash.empty?
    assert_redirected_to user
    assert_nil @user.reload.reset_digest
  end

  test "expired password token" do
    get new_password_reset_path
    post password_resets_path,
         params: { password_reset: { email: @user.email } }

    @user = assigns(:user)
    @user.update_attribute(:reset_sent_at, 3.hours.ago)
    patch password_reset_path(@user.reset_token),
          params: { email: @user.email,
                    user: { password:               "fuubaration",
                            password_confirmation:  "fuubaration" } }
    assert_response :redirect
    follow_redirect!
    assert_match /Expired/i, response.body
  end
end
