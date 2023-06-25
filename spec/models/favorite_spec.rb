# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe 'バリデーション' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:tweet) { FactoryBot.create(:tweet) }

    it 'お気に入りが正しく作成されること' do
      favorite = FactoryBot.build(:favorite)
      expect(favorite).to be_valid
    end

    it '同一ユーザーが同一ツイートを複数回お気に入りできないこと' do
      FactoryBot.create(:favorite, user: user, tweet: tweet)
      duplicate_favorite = FactoryBot.build(:favorite, user: user, tweet: tweet)
      expect(duplicate_favorite).not_to be_valid
    end
  end

  describe '通知' do
    let(:user) { FactoryBot.create(:user) }
    let(:tweet) { FactoryBot.create(:tweet) }

    it 'お気に入りが作成された時に通知が作成されること' do
      FactoryBot.create(:favorite, user: user, tweet: tweet)

      notification = Notification.last
      favorite = described_class.last

      expect(notification.subject).to eq(favorite)
      expect(notification.user).to eq(tweet.user)
      expect(notification.action_type).to eq('favorite')
    end
  end
end
