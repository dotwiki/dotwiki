class CreateRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :requests do |t|
      t.integer :wiki_id
      t.integer :page_id
      t.integer :user_id
      t.text :content
      t.string :comme

      t.timestamps
    end
  end
end
