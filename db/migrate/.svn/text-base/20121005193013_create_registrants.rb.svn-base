class CreateRegistrants < ActiveRecord::Migration
  def change
    create_table :registrants do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :email
      t.string :affiliation
      t.boolean :wednesday
      t.boolean :thursday
      t.boolean :friday
      t.string :food_preference
      t.string :special_needs
      t.string :token

      t.timestamps
    end
  end
end
