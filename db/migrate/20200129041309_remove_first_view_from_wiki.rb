class RemoveFirstViewFromWiki < ActiveRecord::Migration[6.0]
  def change
    remove_column :wikis, :first_view, :text
  end
end
