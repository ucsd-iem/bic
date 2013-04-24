class AddAttachmentBiosketchToAbstracts < ActiveRecord::Migration
  def self.up
    change_table :abstracts do |t|
      t.has_attached_file :biosketch
    end
  end

  def self.down
    drop_attached_file :abstracts, :biosketch
  end
end
