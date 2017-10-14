require 'test_helper'

class TicketTest < ActiveSupport::TestCase

  def setup
    @user = users(:patrick)
    @ticket = Ticket.new(message: "Cannot restart PC", user_id: @user.id)
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

  test "message should be at most 140 characters" do
    @ticket.message = "a" * 141
    assert_not @ticket.valid?
  end
end
