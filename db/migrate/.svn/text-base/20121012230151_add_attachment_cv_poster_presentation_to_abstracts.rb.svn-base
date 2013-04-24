class AddAttachmentCvPosterPresentationToAbstracts < ActiveRecord::Migration
  def self.up
    change_table :abstracts do |t|
      t.has_attached_file :poster
      t.has_attached_file :presentation
    end
  end

  def self.down
    drop_attached_file :abstracts, :poster
    drop_attached_file :abstracts, :presentation
  end
end
