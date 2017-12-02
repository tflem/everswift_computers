require 'test_helper'

class TicketsEditTest < ActionDispatch::IntegrationTest

  def setup
    @current_user = users(:patrick)
    @ticket       = tickets(:one)
  end

  test "unsuccessful edit ticket" do
    log_in_as(@current_user)
    get edit_ticket_path(@ticket)
    assert_template "tickets/edit"
    patch ticket_path(@ticket), params: { ticket: { category: "Technical",
                                                    title:    "",
                                                    message:  "Blue screen, help.",
                                                    status:   "Open" } }
    follow_redirect!
    assert_template "tickets/edit"
    assert_not flash.empty?
    assert_equal "Title/Message Fields Cannot Be Blank.", flash[:alert]
  end
end
