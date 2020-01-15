class AddNavToWiki < ActiveRecord::Migration[6.0]
  def change
    add_column :wikis, :nav, :jsonb, index: true
  end
end
