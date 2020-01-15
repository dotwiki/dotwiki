class CreateWikis < ActiveRecord::Migration[6.0]
  def change
    create_table :wikis do |t|
      t.string :title, index: true, null: false
      t.text :description
      t.text :terms
      t.text :first_view
      t.boolean :can_contributor_edit, index: true, default: true

      t.timestamps
    end
  end
end
