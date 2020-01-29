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

  before_create :add_wiki_string
  after_create :wiki_initializer

  private 

  def wiki_initializer
    page = self.pages.new(
      title: "ようこそ#{self.title}へ！",
    )
    his = page.histories.new(
      content: "まずはほげほげしましょう"
    )
    page.save
    his.save
    
    self.nav = [{page_id: page.id}]
    self.save
  end

  def add_wiki_string
    unless self.title.match(/wiki/i)
      self.title << ' Wiki'
    end
  end
end
