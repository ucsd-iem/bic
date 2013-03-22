class CreateSponsors < ActiveRecord::Migration
  def change
    create_table :sponsors do |t|
      t.string :name
      t.string :url
      t.string :email
      t.string :phone
      t.string :level
      t.integer :position

      t.timestamps
    end
  end
end
