class AddLevelToWikiMaintainer < ActiveRecord::Migration[6.0]
  def change
    add_column :wiki_maintainers, :level, :integer, null: false, default: 1
  end
end
