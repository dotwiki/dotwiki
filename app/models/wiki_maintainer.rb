# == Schema Information
#
# Table name: wiki_maintainers
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#  wiki_id    :bigint           not null
#
# Indexes
#
#  index_wiki_maintainers_on_user_id  (user_id)
#  index_wiki_maintainers_on_wiki_id  (wiki_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#  fk_rails_...  (wiki_id => wikis.id)
#

class WikiMaintainer < ApplicationRecord
  belongs_to :user
  belongs_to :wiki
end
