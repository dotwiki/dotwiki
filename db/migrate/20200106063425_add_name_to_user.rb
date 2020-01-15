class AddNameToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string, index: true, null: false
  end
end
