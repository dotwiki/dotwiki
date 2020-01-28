# == Schema Information
#
# Table name: wikis
#
#  id                     :bigint           not null, primary key
#  can_navs_edit_level    :integer          default(2), not null
#  can_page_archive_level :integer          default(2), not null
#  can_page_create_level  :integer          default(1), not null
#  can_page_edit_level    :integer          default(2), not null
#  can_page_frozen_level  :integer          default(2), not null
#  can_page_request_level :integer          default(0), not null
#  description            :text
#  first_view             :text
#  nav                    :jsonb
#  terms                  :text
#  title                  :string           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
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
