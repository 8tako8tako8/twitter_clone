# frozen_string_literal: true

class Retweet < ApplicationRecord
  after_create_commit :create_notification

  belongs_to :tweet
  belongs_to :user
  has_one :notification, as: :subject, dependent: :destroy

  validates :tweet, presence: true, uniqueness: { scope: :user }

  private

  def create_notification
    Notification.create(subject: self, user: tweet.user, action_type: Notification.action_types[:retweet])
  end
end
