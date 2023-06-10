# frozen_string_literal: true

class Room < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy

  def message(user, message_params)
    message = messages.build(message_params)
    message.user_id = user.id
    message.save
    message
  end
end
