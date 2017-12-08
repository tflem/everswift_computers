require 'test_helper'

class TicketsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @ticket = tickets(:one)
  end

  test "should redirect new when not logged in" do
    get new_ticket_path(@ticket)
    assert_not flash.empty?
    assert_redirected_to login_url
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

  test "should redirect edit when not logged in" do
    get edit_ticket_path(@ticket)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch ticket_path(@ticket), params: { ticket: { category: @ticket.category,
                                                    title:    @ticket.title,
                                                    message:  @ticket.message,
                                                    status:   @ticket.status } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference "Ticket.count" do
      delete ticket_path(@ticket)
    end
    assert_redirected_to login_url
  end
end
