# == Schema Information
#
# Table name: requests
#
#  id         :bigint           not null, primary key
#  comme      :string
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  page_id    :integer
#  user_id    :integer
#  wiki_id    :integer
#

class Request < ApplicationRecord
end
