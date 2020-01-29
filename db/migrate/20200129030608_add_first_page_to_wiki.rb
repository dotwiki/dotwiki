class AddFirstPageToWiki < ActiveRecord::Migration[6.0]
  def change
    add_column :wikis, :first_page_id, :integer
  end
end
