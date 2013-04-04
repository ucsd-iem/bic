class AddFieldsToSponsor < ActiveRecord::Migration
  def change
    change_table :sponsors do |t|
      t.string :contact_name
      t.string :contact_email
      t.string :contact_phone
      t.text :tagline
      t.text :mission_statement
      t.has_attached_file :logo
    end
  end
end
