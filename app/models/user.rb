# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable, :omniauthable, omniauth_providers: %i[github]

  has_many :tweets, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :retweets, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :active_relationships, class_name: 'Follow', foreign_key: 'follower_user_id', dependent: :destroy, inverse_of: :follower_user
  has_many :followings, through: :active_relationships, source: :followed_user
  has_many :passive_relationships, class_name: 'Follow', foreign_key: 'followed_user_id', dependent: :destroy, inverse_of: :followed_user
  has_many :followers, through: :passive_relationships, source: :follower_user
  has_one_attached :image
  has_one_attached :header_image

  validates :tel, presence: true, unless: :github_provider?
  validates :user_name, presence: true, unless: :github_provider?
  validates :birthdate, presence: true, unless: :github_provider?
  validates :uid, presence: true, uniqueness: { scope: :provider }
  validates :website_url, format: /\A#{URI::DEFAULT_PARSER.make_regexp(%w[http https])}\z/, allow_blank: true

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

  def favorite(tweet)
    favorites.find_or_create_by(tweet: tweet)
  end

  def unfavorite(tweet)
    favorites.find_by(tweet: tweet).destroy
  end

  def retweet(tweet)
    retweets.find_or_create_by(tweet: tweet)
  end

  def comment(comment, tweet)
    comments.create(comment: comment, tweet: tweet)
  end

  private

  def github_provider?
    provider == 'github'
  end
end
