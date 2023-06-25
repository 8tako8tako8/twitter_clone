# frozen_string_literal: true

class Comment < ApplicationRecord
  after_create_commit :create_notification

  belongs_to :tweet
  belongs_to :user
  has_one :notification, as: :subject, dependent: :destroy

  validates :comment, presence: true, length: { maximum: 140 }

  def create_notification
    Notification.create(subject: self, user: tweet.user, action_type: Notification.action_types[:comment])
  end
end
