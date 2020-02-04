# == Schema Information
#
# Table name: notifications
#
#  id         :bigint           not null, primary key
#  key_name   :string
#  path       :string
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  wiki_id    :integer
#
# Indexes
#
#  index_notifications_on_key_name  (key_name)
#  index_notifications_on_path      (path)
#  index_notifications_on_title     (title)
#  index_notifications_on_wiki_id   (wiki_id)
#

class Notification < ApplicationRecord
  belongs_to :wiki
  validates :key_name, uniqueness: true
end
