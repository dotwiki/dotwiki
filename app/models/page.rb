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

  after_create :push_create_news
  after_update :push_update_news

  private 

  def push_create_news
    path = Rails.application.routes.url_helpers.wiki_page_path(self.wiki, self)
    self.wiki.push_news(path: path, obj: self, title: "#{self.title}が作成されました")
  end

  def push_update_news
    path = Rails.application.routes.url_helpers.wiki_page_path(self.wiki, self)
    self.wiki.push_news(path: path, obj: self, title: "#{self.title}が更新されました")
  end
end
