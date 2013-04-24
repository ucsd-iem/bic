class CreateAbstracts < ActiveRecord::Migration
  def change
    create_table :abstracts do |t|
      t.string :title
      t.string :authors
      t.text :affiliations
      t.string :email
      t.text :body
      t.text :personal_statement
      t.string :video_url
      t.integer :year
      t.integer :attendee_id
      t.integer :order_id
      
      t.timestamps
    end
  end
end
