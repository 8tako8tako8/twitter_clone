# frozen_string_literal: true

FactoryBot.define do
  factory :message do
    message { 'テストメッセージ' }
    association :user
    association :room
  end
end
