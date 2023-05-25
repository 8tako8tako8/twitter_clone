# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable, :omniauthable, omniauth_providers: %i[github]

  has_many :tweets, dependent: :destroy
  has_many :active_relationships, class_name: 'Follow', foreign_key: 'follower_user_id', dependent: :destroy
  has_many :followings, through: :active_relationships, source: :followed_user
  has_many :passive_relationships, class_name: 'Follow', foreign_key: 'followed_user_id', dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower_user
  has_one_attached :image

  validates :tel, presence: true, unless: :github_provider?
  validates :user_name, presence: true, unless: :github_provider?
  validates :birthdate, presence: true, unless: :github_provider?
  validates :uid, presence: true, uniqueness: { scope: :provider }

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.confirmed_at = Time.zone.now
    end
  end

  def self.create_unique_string
    SecureRandom.uuid
  end

  def follow(user)
    active_relationships.create(followed_user_id: user.id)
  end

  private

  def github_provider?
    provider == 'github'
  end
end
