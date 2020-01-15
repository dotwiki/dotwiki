# == Schema Information
#
# Table name: watches
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#  wiki_id    :bigint           not null
#
# Indexes
#
#  index_watches_on_user_id  (user_id)
#  index_watches_on_wiki_id  (wiki_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#  fk_rails_...  (wiki_id => wikis.id)
#

require 'test_helper'

class WatchTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
