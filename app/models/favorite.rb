# frozen_string_literal: true

class Favorite < ApplicationRecord
  after_create_commit :create_notification

  belongs_to :tweet
  belongs_to :user
  has_one :notification, as: :subject, dependent: :destroy

  def create_notification
    Notification.create(subject: self, user: tweet.user, action_type: Notification.action_types[:favorite])
  end
end
