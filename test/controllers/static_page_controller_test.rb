require 'test_helper'

class StaticPageControllerTest < ActionDispatch::IntegrationTest

  def setup
  	@base_title = "EverSwift Computers"
  end

  test "should get root" do
  	get root_url
  	assert_response :success
  end

  test "should get home" do
    get static_page_home_url
    assert_response :success
    assert_select "title", "Home | #{@base_title}"
  end
end
