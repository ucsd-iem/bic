class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :barcode
      t.string :currency
      t.integer :quantity
      t.integer :ebrite_id
      t.integer :ebrite_event_id
      t.integer :ebrite_order_id
      t.integer :ebrite_ticket_id
      t.integer :attendee_id

      t.timestamps
    end
  end
end
