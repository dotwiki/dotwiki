class AddCanEditToWiki < ActiveRecord::Migration[6.0]
  def change
    add_column :wikis, :can_edit, :integer, null: false, default: 1
  end
end
