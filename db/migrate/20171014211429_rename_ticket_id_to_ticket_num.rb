class RenameTicketIdToTicketNum < ActiveRecord::Migration[5.1]
  def change
    rename_column :tickets, :ticket_id, :ticket_num
  end
end
