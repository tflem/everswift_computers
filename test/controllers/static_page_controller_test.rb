require 'test_helper'

class StaticPageControllerTest < ActionDispatch::IntegrationTest

  test "should get home" do
  	get root_path
  	assert_response :success
    assert_select "title", "EverSwift Computers"
  end  
end
