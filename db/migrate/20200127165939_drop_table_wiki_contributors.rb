class DropTableWikiContributors < ActiveRecord::Migration[6.0]
  def change
    drop_table :wiki_contributors
  end
end
