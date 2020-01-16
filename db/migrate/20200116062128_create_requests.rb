class CreateRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :requests do |t|
      t.integer :wiki_id, index: true
      t.integer :page_id, index: true
      t.integer :user_id, index: true
      t.text :content, null: false
      t.string :comment, null: false

      t.timestamps
    end
  end
end
