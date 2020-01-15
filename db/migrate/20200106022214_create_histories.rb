class CreateHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :histories do |t|
      t.integer :page_id, index: true
      t.integer :user_id, index: true
      t.text :content
      t.string :comment, index: true
      
      t.timestamps
    end
  end
end
