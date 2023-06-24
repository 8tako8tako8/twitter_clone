FactoryBot.define do
  factory :follow do
    association :follower_user, factory: :user
    association :followed_user, factory: :user
  end
end
