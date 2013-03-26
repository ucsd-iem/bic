class CreateAttendees < ActiveRecord::Migration
  def change
    create_table :attendees do |t|
      t.string :first_name
      t.string :last_name
      t.string :email,              :null => false, :default => ""
      t.datetime :created
      t.datetime :modified

      t.timestamps
    end
  end
end
