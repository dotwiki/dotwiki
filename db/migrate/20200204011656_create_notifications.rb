class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.string :key_name, unique: true, index: true
      t.string :title, index: true
      t.string :path, index: true
      t.integer :wiki_id, index: true

      t.timestamps
    end
  end
end
