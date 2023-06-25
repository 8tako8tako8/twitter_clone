# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'バリデーション' do
    it 'コメントが正しく作成できること' do
      comment = FactoryBot.build(:comment)
      expect(comment).to be_valid
    end

    it 'コメントがnilの場合にエラーになること' do
      comment = FactoryBot.build(:comment, comment: nil)
      expect(comment).not_to be_valid
    end

    it 'コメントの文字数が140字を超えた場合にエラーとなること' do
      comment = FactoryBot.build(:comment, comment: 'a' * 141)
      expect(comment).not_to be_valid
    end
  end

  describe '通知' do
    let(:user) { FactoryBot.create(:user) }
    let(:tweet) { FactoryBot.create(:tweet) }

    it 'お気に入りが作成された時に通知が作成されること' do
      FactoryBot.create(:comment, user: user, tweet: tweet)

      notification = Notification.last
      comment = Comment.last

      expect(notification.subject).to eq(comment)
      expect(notification.user).to eq(tweet.user)
      expect(notification.action_type).to eq('comment')
    end
  end
end
