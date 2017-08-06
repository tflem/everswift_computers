require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title, "EverSwift Computers"
    assert_equal full_title("Sign Up"), "Sign Up | EverSwift Computers"
  end
end
