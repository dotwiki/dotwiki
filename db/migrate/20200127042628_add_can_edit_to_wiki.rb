class AddCanEditToWiki < ActiveRecord::Migration[6.0]
  def change
    add_column :wikis, :can_page_create_level, :integer, null: false, default: 1
    add_column :wikis, :can_page_edit_level, :integer, null: false, default: 2
    add_column :wikis, :can_page_request_level, :integer, null: false, default: 0
    add_column :wikis, :can_page_frozen_level, :integer, null: false, default: 2
    add_column :wikis, :can_page_archive_level, :integer, null: false, default: 2
    add_column :wikis, :can_navs_edit_level, :integer, null: false, default: 2
  end
end
