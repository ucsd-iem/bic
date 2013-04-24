class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :start
      t.datetime :stop
      t.integer :abstract_id
      t.integer :session

      t.timestamps
    end
  end
end
