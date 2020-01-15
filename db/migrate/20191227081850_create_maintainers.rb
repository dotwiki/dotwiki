class CreateMaintainers < ActiveRecord::Migration[6.0]
  def change
    create_table :wiki_maintainers do |t|
      t.references :user, index: true, null: false, foreign_key: true
      t.references :wiki, index: true, null: false, foreign_key: true

      t.timestamps
    end
  end
end
