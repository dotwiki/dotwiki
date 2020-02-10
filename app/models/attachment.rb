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

class Attachment < ApplicationRecord
  belongs_to :wiki
  mount_uploader :file, FileUploader

  validates :shortcode, uniqueness: { scope: :wiki_id }

  before_commit :set_default_shortcode
  
  private

  def set_default_shortcode
    if self.shortcode.nil?
      self.shortcode = SecureRandom.hex(6)
      self.save
    end
  end
end
