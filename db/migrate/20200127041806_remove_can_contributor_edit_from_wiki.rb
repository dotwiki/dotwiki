class RemoveCanContributorEditFromWiki < ActiveRecord::Migration[6.0]
  def change

    remove_column :wikis, :can_contributor_edit, :boolean
  end
end
