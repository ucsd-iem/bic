class CreateAttendees < ActiveRecord::Migration
  def change
    create_table :attendees do |t|
      t.integer :eid
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :order_type
      t.string :barcode
      t.integer :order_id
      t.float :amount_paid
      t.string :currency
      t.string :discount
      t.integer :quantity
      t.integer :ticket_id
      t.integer :event_id, :limit => 8
      t.string :event_date
      t.datetime :created
      t.datetime :modified

      t.timestamps
    end
  end
end
