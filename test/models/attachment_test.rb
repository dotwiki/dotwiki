# == Schema Information
#
# Table name: attachments
#
#  id         :bigint           not null, primary key
#  file       :string
#  shortcode  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  wiki_id    :integer
#
# Indexes
#
#  index_attachments_on_wiki_id  (wiki_id)
#

require 'test_helper'

class AttachmentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
