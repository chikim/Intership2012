# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  mail       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  attr_accessible :email, :name, :password, :password_confirmation

  has_many :microposts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  has_secure_password

  validates :name, presence: true,
                   length: { maximum: 50 }
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: { with: VALID_EMAIL_REGEX }
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  before_save do |user|
    user.email = email.downcase
    create_remember_token
  end

  def feed
    Micropost.from_users_followed_by(self)
  end

  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end

  private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end
