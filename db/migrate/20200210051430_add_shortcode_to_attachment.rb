class AddShortcodeToAttachment < ActiveRecord::Migration[6.0]
  def change
    add_column :attachments, :shortcode, :string
  end
end
