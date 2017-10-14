class CreateTickets < ActiveRecord::Migration[5.1]
  def change
    create_table :tickets do |t|
      t.string :title
      t.string :priority
      t.text :message
      t.string :status
      t.integer :category_id
      t.string :ticket_id, unique: true
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :tickets, [:user_id, :created_at]
  end
end
