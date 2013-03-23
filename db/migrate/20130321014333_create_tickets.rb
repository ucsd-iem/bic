class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.integer :eid
      t.string :barcode
      t.string :currency
      t.integer :order_id
      t.integer :quantity
      t.integer :ticket_id
      t.integer :event_id
      t.integer :attendee_id

      t.timestamps
    end
  end
end
