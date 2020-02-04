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
#  nav                    :jsonb
#  terms                  :text
#  title                  :string           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  first_page_id          :integer
#
# Indexes
#
#  index_wikis_on_title  (title)
#

class Wiki < ApplicationRecord
  has_many :wiki_maintainers, dependent: :delete_all
  has_many :maintainers, through: :wiki_maintainers, source: :user
  accepts_nested_attributes_for :wiki_maintainers
  has_many :watches, dependent: :delete_all
  has_many :watchers, through: :watches, source: :user
  has_many :pages, dependent: :delete_all
  has_many :requests, dependent: :destroy
  has_many :attachments, dependent: :delete_all
  has_many :notifications, dependent: :destroy

  before_create :add_wiki_string
  after_create :wiki_initializer

  def push_news(path: nil, obj:, title:)
    key_name = "#{obj.class.name}:#{obj.id}"

    record = self.notifications.find_or_initialize_by(key_name: key_name)
    record.title = title
    record.path = path
    record.save
  end

  private
  
  def add_wiki_string
    unless self.title.match(/wiki/i)
      self.title << " Wiki"
    end
  end

  def wiki_initializer
    page = self.pages.new(
      title: "ようこそ#{self.title}へ！",
    )
    page.save

    his = page.histories.new(
      content: "まずはほげほげしましょう",
    )
    his.save

    self.nav = [{ page_id: page.id }]
    self.first_page_id = page.id
    self.save
  end
end
