require 'test_helper'

class TicketTest < ActiveSupport::TestCase

  def setup
    @user = users(:patrick)
    @ticket = @user.tickets.build(message: "Need to buy RAM")
  end

  test "should be valid" do
    assert @ticket.valid?
  end

  test "user id should be present" do
    @ticket.user_id = nil
    assert_not @ticket.valid?
  end

  test "message should be present" do
    @ticket.message = "   "
    assert_not @ticket.valid?
  end

  test "message should be at most 150 characters" do
    @ticket.message = "a" * 151
    assert_not @ticket.valid?
  end

  test "order should be most recent first" do
    assert_equal tickets(:most_recent), Ticket.first
  end
end
