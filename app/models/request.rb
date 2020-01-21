# == Schema Information
#
# Table name: requests
#
#  id         :bigint           not null, primary key
#  comment    :string           not null
#  content    :text             not null
#  diff       :jsonb
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  page_id    :integer
#  user_id    :integer
#  wiki_id    :integer
#
# Indexes
#
#  index_requests_on_page_id  (page_id)
#  index_requests_on_user_id  (user_id)
#  index_requests_on_wiki_id  (wiki_id)
#

class Request < ApplicationRecord
  belongs_to :wiki
  belongs_to :page
  belongs_to :user

  validates :comment, length: {maximum: 50}
end
