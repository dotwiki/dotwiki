class AddDiffToRequest < ActiveRecord::Migration[6.0]
  def change
    add_column :requests, :diff, :jsonb
  end
end
