require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  test "layout links" do
    get root_path
    assert_template "static_page/home"
    assert_select "a[href=?]", root_path
    assert_select "section#company-introduction"
    assert_select "section#services"
    assert_select "section#products"
    assert_select "section#about"
  end
end
