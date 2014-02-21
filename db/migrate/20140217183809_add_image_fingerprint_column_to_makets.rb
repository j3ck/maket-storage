class AddImageFingerprintColumnToMakets < ActiveRecord::Migration
  def self.up
    add_column :makets, :image_fingerprint, :string
  end

  def self.down
    remove_column :makets, :image_fingerprint
  end
end
