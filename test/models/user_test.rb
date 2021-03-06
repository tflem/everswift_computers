require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
	  @user = User.new(name: "Example User", email: "user@example.com",
                     password: "fuuubarr", password_confirmation: "fuuubarr")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
  	@user.name = ""
  	assert_not @user.valid?
  end

  test "email should be present" do
  	@user.email = "     "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
     assert_not @user.valid?
  end

  test "email validation should except valid addresses" do
    valid_addresses = %w[user@example.com USER@fuu.COM A_US-CD@fuu.bar.org
                         first.last@fuu.jp alvin+barb@yaz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation sould reject invalid addresses" do
  	invalid_addresses = %w[user@example,com user_at_fuu.org user.name@example.
  	                       fuu@bar_bat.com foo@bar+bat.com foo@bar..com]
  	invalid_addresses.each do |invalid_address|
  	  @user.email = invalid_address
  	  assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
  	end
  end

  test "email addresses should be unique" do
  	duplicate_user = @user.dup
  	duplicate_user.email = @user.email.upcase
  	@user.save
  	assert_not duplicate_user.valid?
  end

  test "email addresses should be saved as lowercase" do
    mixed_case_email = "Fuu@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 8
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 7
    assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, "")
  end

  test "associated tickets should be destroyed" do
    @user.save
    @user.tickets.create!(category: "Technical",
                          title:    "PC won't boot",
                          status:   "Open",
                          message:  "PC stalls at startup screen, please help.")
    assert_difference "Ticket.count", -1 do
      @user.destroy
    end
  end
end
