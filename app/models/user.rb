# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable, :omniauthable, omniauth_providers: %i[github]

  has_many :tweets, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :retweets, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :active_relationships, class_name: 'Follow', foreign_key: 'follower_user_id', dependent: :destroy, inverse_of: :follower_user
  has_many :followings, through: :active_relationships, source: :followed_user
  has_many :passive_relationships, class_name: 'Follow', foreign_key: 'followed_user_id', dependent: :destroy, inverse_of: :followed_user
  has_many :followers, through: :passive_relationships, source: :follower_user
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :rooms, through: :entries
  has_many :notifications, dependent: :destroy
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
    return unless id != user.id

    active_relationships.find_or_create_by(followed_user_id: user.id)
  end

  def unfollow(user)
    return unless id != user.id

    active_relationships.find_by(followed_user_id: user.id)&.destroy
  end

  def favorite(tweet)
    favorites.find_or_create_by(tweet: tweet)
  end

  def unfavorite(tweet)
    favorites.find_by(tweet: tweet)&.destroy
  end

  def retweet(tweet)
    retweets.find_or_create_by(tweet: tweet)
  end

  def unretweet(tweet)
    retweets.find_by(tweet: tweet)&.destroy
  end

  def comment(comment, tweet)
    comments.create(comment: comment, tweet: tweet)
  end

  def bookmark(tweet)
    bookmarks.find_or_create_by(tweet: tweet)
  end

  def unbookmark(tweet)
    bookmarks.find_by(tweet: tweet)&.destroy
  end

  def room(user)
    common_room = common_room(user)

    return common_room if common_room

    room = Room.create
    room.entries.create(user_id: id)
    room.entries.create(user_id: user.id)
    room
  end

  def common_room(user)
    (rooms & user.rooms).first
  end

  private

  def github_provider?
    provider == 'github'
  end
end
