class AddColumnToTickets < ActiveRecord::Migration[5.1]
  def change
    add_column :tickets, :slug, :string
    add_index :tickets, :slug, unique: true
  end
end
