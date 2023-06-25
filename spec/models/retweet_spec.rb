# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Retweet, type: :model do
  describe 'バリデーション' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:tweet) { FactoryBot.create(:tweet) }

    it 'リツイートが正しく作成されること' do
      retweet = FactoryBot.build(:retweet)
      expect(retweet).to be_valid
    end

    it '同一ユーザーが同一ツイートを複数回リツイートできないこと' do
      FactoryBot.create(:retweet, user: user, tweet: tweet)
      duplicate_retweet = FactoryBot.build(:retweet, user: user, tweet: tweet)
      expect(duplicate_retweet).not_to be_valid
    end
  end

  describe '通知' do
    let(:user) { FactoryBot.create(:user) }
    let(:tweet) { FactoryBot.create(:tweet) }

    it 'リツイートが作成された時に通知が作成されること' do
      FactoryBot.create(:retweet, user: user, tweet: tweet)

      notification = Notification.last
      retweet = Retweet.last

      expect(notification.subject).to eq(retweet)
      expect(notification.user).to eq(tweet.user)
      expect(notification.action_type).to eq('retweet')
    end
  end
end
