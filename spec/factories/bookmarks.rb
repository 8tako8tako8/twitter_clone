# frozen_string_literal: true

FactoryBot.define do
  factory :bookmark do
    association :user
    association :tweet
  end
end
