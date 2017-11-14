require 'test_helper'

class UsersTicketTest < ActionDispatch::IntegrationTest

  def setup
    @current_user = users(:patrick)
  end

  test "invalid ticket information" do
    log_in_as(@current_user)
    get new_ticket_path
    assert_no_difference "Ticket.count" do
      post tickets_path, params: { ticket: { category: "",
                                             title:    "Missing RAM",
                                             status:   "Open",
                                             message:  "Bought 2, Received 1" } }
   end
   assert_template "tickets/new"
   assert_select "div#error_explanation"
   assert_select "div.field_with_errors"
 end

 test "valid ticket information" do
   log_in_as(@current_user)
   get new_ticket_path
   assert_difference "Ticket.count", 1 do
     post tickets_path, params: { ticket: { category: "Sales",
                                            title:    "Missing RAM",
                                            status:   "Open",
                                            message:  "Bought 2, Received 1" } }
   end
   follow_redirect!
   assert_template "users/show"
   assert_not flash.empty?
 end
end
