# == Schema Information
#
# Table name: histories
#
#  id         :bigint           not null, primary key
#  comment    :string
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  page_id    :integer
#  user_id    :integer
#
# Indexes
#
#  index_histories_on_comment  (comment)
#  index_histories_on_page_id  (page_id)
#  index_histories_on_user_id  (user_id)
#

class History < ApplicationRecord
  belongs_to :page
  belongs_to :user, optional: true
  validates :content, presence: true
end
