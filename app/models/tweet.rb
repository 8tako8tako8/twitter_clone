# frozen_string_literal: true

class Tweet < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :retweets, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :image

  validates :tweet, presence: true, length: { maximum: 140 }
end
