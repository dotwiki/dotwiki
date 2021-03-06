# == Schema Information
#
# Table name: users
#
#  id                                  :bigint           not null, primary key
#  access_count_to_reset_password_page :integer          default(0)
#  activation_state                    :string
#  activation_token                    :string
#  activation_token_expires_at         :datetime
#  avatar                              :string
#  avatar_cache                        :string
#  crypted_password                    :string
#  email                               :string           not null
#  name                                :string           not null
#  remember_me_token                   :string
#  remember_me_token_expires_at        :datetime
#  reset_password_email_sent_at        :datetime
#  reset_password_token                :string
#  reset_password_token_expires_at     :datetime
#  salt                                :string
#  sns_image                           :string
#  created_at                          :datetime         not null
#  updated_at                          :datetime         not null
#
# Indexes
#
#  index_users_on_activation_token      (activation_token)
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_remember_me_token     (remember_me_token)
#  index_users_on_reset_password_token  (reset_password_token)
#

class User < ApplicationRecord
  include Redis::Objects
  authenticates_with_sorcery!

  list :notices, marshal: true

  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  has_many :wikis, through: :wiki_maintainers
  has_many :wiki_maintainers, dependent: :destroy

  has_many :wikis, through: :watches
  has_many :watches, dependent: :destroy
  has_many :requests, dependent: :destroy

  mount_uploader :avatar, AvatarUploader

  before_save { self.email = email.downcase }
  before_save { self.name = SecureRandom.hex(6) if self.name.nil? }

  validates :email, presence: true
  validates :email, uniqueness: true
  validates :email, uniqueness: { case_sensitive: false }
  VALID_EMAIL_REGEX = /\A[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*\z/
  validates :email, format: { with: VALID_EMAIL_REGEX }
  validates_acceptance_of :agreement, allow_nil: false, on: :create

  after_create :new_user_initializer

  def current_avatar
    self.avatar_url || self.sns_image || Identicon.data_url_for(self.id)
  end

  def push_notice(path: "#", title:)
    self.notices << {
      path: path,
      title: title,
      date: DateTime.now.to_s,
    }
  end

  def pop_notice(pos)
    self.notices.pop(pos)
  end

  private

  def new_user_initializer
    self.push_notice(path: "/wikis/1", title: "dotwikiへようこそ🎉")
  end
end
