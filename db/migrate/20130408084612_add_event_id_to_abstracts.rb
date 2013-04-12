class AddEventIdToAbstracts < ActiveRecord::Migration
  def change
    add_column :abstracts, :event_id, :integer
  end
end
