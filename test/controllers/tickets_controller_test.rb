require 'test_helper'

class TicketsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @ticket = tickets(:one)
  end

  test "should redirect create when not logged in" do
    assert_no_difference "Ticket.count" do
      post tickets_path, params: { ticket: { category: "Technical",
                                             title:    "",
                                             message:  "Blue screen, help.",
                                             status:   "Open" } }
    end
    assert_redirected_to login_url
  end
end
