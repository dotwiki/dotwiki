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

class Page < ApplicationRecord
  belongs_to :wiki
  has_many :histories, inverse_of: :page
  has_one :latest_history, -> { order(created_at: :desc) }, class_name: :History
  accepts_nested_attributes_for :histories, limit: 1
  has_many :requests, dependent: :destroy
end
