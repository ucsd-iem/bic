class AddAttachmentBiosketchPhotoToModerators < ActiveRecord::Migration
  def self.up
    change_table :moderators do |t|
      t.has_attached_file :biosketch
      t.has_attached_file :photo
    end
  end

  def self.down
    drop_attached_file :moderators, :biosketch
    drop_attached_file :moderators, :photo
  end
end
