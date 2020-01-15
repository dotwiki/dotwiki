# == Schema Information
#
# Table name: pages
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  wiki_id    :integer          not null
#
# Indexes
#
#  index_pages_on_title    (title)
#  index_pages_on_wiki_id  (wiki_id)
#

require 'test_helper'

class PageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
