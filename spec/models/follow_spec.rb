# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Follow, type: :model do
  describe 'バリデーション' do
    let(:follower_user) { FactoryBot.create(:user) }
    let(:followed_user) { FactoryBot.create(:user) }
    let(:follow) { FactoryBot.build(:follow, follower_user: follower_user, followed_user: followed_user) }

    it '正しくフォローが作成されること' do
      expect(follow).to be_valid
    end

    it 'フォロワーユーザーIDがnilだとエラーとなること' do
      follow.follower_user_id = nil
      expect(follow).not_to be_valid
    end

    it 'フォローされたユーザーIDがnilだとエラーになること' do
      follow.followed_user_id = nil
      expect(follow).not_to be_valid
    end

    it '同じフォローに組み合わせの場合にエラーとなること' do
      FactoryBot.create(:follow, follower_user: follower_user, followed_user: followed_user)
      duplicate_follow = FactoryBot.build(:follow, follower_user: follower_user, followed_user: followed_user)
      expect(duplicate_follow).not_to be_valid
    end
  end
end
