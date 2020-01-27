# == Schema Information
#
# Table name: requests
#
#  id         :bigint           not null, primary key
#  comment    :string           not null
#  content    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  history_id :integer
#  page_id    :integer
#  user_id    :integer
#  wiki_id    :integer
#
# Indexes
#
#  index_requests_on_history_id  (history_id)
#  index_requests_on_page_id     (page_id)
#  index_requests_on_user_id     (user_id)
#  index_requests_on_wiki_id     (wiki_id)
#

require 'test_helper'

class RequestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
