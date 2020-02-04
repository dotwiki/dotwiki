# == Schema Information
#
# Table name: wiki_notifications
#
#  id         :bigint           not null, primary key
#  key_name   :string
#  path       :string
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class WikiNotificationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
