require 'rails_helper'

RSpec.describe Tweet, type: :model do
  describe 'バリデーション' do
    it 'ツイートが正しく作成できること' do
      tweet = FactoryBot.build(:tweet)
      expect(tweet).to be_valid
    end

    it 'ツイートがnilの場合にエラーになること' do
      tweet = FactoryBot.build(:tweet, tweet: nil)
      expect(tweet).not_to be_valid
    end
    
    it 'ツイートが文字数が140字を超えた場合にエラーとなること' do
      tweet = FactoryBot.build(:tweet, tweet: 'a' * 141)
      expect(tweet).not_to be_valid
    end
  end

  describe '#count_favorites' do
    let!(:user1) { FactoryBot.create(:user) }
    let!(:user2) { FactoryBot.create(:user) }
    let!(:user3) { FactoryBot.create(:user) }
    let!(:tweet) { FactoryBot.create(:tweet, user: user1) }

    it 'ツイートのお気に入り数2が返ってくること' do
      FactoryBot.create(:favorite, user: user1, tweet: tweet)
      FactoryBot.create(:favorite, user: user2, tweet: tweet)
      expect(tweet.count_favorites).to eq(2)
    end
  end

  describe '#count_retweets' do
    let!(:user1) { FactoryBot.create(:user) }
    let!(:user2) { FactoryBot.create(:user) }
    let!(:user3) { FactoryBot.create(:user) }
    let!(:tweet) { FactoryBot.create(:tweet, user: user1) }

    it 'ツイートのリツイート数2が返ってくること' do
      FactoryBot.create(:retweet, user: user1, tweet: tweet)
      FactoryBot.create(:retweet, user: user2, tweet: tweet)
      expect(tweet.count_retweets).to eq(2)
    end
  end
end
