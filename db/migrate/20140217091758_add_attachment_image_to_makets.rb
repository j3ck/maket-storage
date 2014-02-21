class AddAttachmentImageToMakets < ActiveRecord::Migration
  def self.up
    change_table :makets do |t|
      t.attachment :image
    end
  end

  def self.down
    drop_attached_file :makets, :image
  end
end
