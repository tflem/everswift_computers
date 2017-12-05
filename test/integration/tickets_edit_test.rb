require 'test_helper'

class TicketsEditTest < ActionDispatch::IntegrationTest

  def setup
    @current_user = users(:patrick)
    @ticket       = tickets(:one)
  end

  test "unsuccessful ticket edit" do
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

  test "successful ticket edit" do
    log_in_as(@current_user)
    get edit_ticket_path(@ticket)
    assert_template "tickets/edit"
    category  = "Sales"
    title     = "Missing SSD"
    message   = "Ordered a SSD, not a HDD. Please, assist."
    status    = "Open"
    patch ticket_path(@ticket), params: { ticket: { category: category,
                                                    title:    title,
                                                    message:  message,
                                                    status:   status   } }
    assert_not flash.empty?
    assert_equal "Your Ticket Has Been Updated.", flash[:success]
    assert_redirected_to @current_user
    @ticket.reload
    assert_equal category, @ticket.category
    assert_equal title,    @ticket.title
    assert_equal message,  @ticket.message
    assert_equal status,   @ticket.status
  end
end
