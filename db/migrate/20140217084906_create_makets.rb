class CreateMakets < ActiveRecord::Migration
  def change
    create_table :makets do |t|
      t.string :name
      t.integer :version_id

      t.timestamps
    end
  end
end
