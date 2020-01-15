class CreatePages < ActiveRecord::Migration[6.0]
  def change
    create_table :pages do |t|
      t.integer :wiki_id, index: true, null: false
      t.string :title, index: true, null: false

      t.timestamps
    end
  end
end
