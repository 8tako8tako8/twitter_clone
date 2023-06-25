# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
    user_name { 'テストユーザー' }
    tel { '00000000000' }
    introduction { '2023年3月〜プログラミング学習中/Ruby,Java,C言語が書けます' }
    birthdate { '1990-01-01' }
    location { 'Tokyo' }
    website_url { 'https://test.example.com' }
    uid { SecureRandom.uuid }
    confirmed_at { Time.zone.now }

    trait :github do
      provider { 'github' }
    end
  end
end
