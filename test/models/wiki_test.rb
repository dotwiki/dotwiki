# == Schema Information
#
# Table name: wikis
#
#  id          :bigint           not null, primary key
#  can_edit    :integer
#  description :text
#  first_view  :text
#  nav         :jsonb
#  terms       :text
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_wikis_on_title  (title)
#

require 'test_helper'

class WikiTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
