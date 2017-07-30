require 'test_helper'

class StaticPageControllerTest < ActionDispatch::IntegrationTest

  test "should get root" do
  	get root_url
  	assert_response :success
  end

  test "should get home" do
    get static_page_home_url
    assert_response :success
    assert_select "title", "EverSwift Computers"
  end
end
