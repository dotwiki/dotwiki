class AddAvatarToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :avatar, :string, index: true
    add_column :users, :avatar_cache, :string, index: true
    add_column :users, :sns_image, :string, index: true
  end
end
