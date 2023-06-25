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
    context 'お気に入りが作成された時' do
      let(:user) { FactoryBot.create(:user) }
      let(:tweet) { FactoryBot.create(:tweet) }
      let(:comment) { FactoryBot.create(:comment, user: user, tweet: tweet) }
      let(:notification) { Notification.where(subject: comment).last }

      it 'subjectがcommentであること' do
        expect(notification.subject).to eq(comment)
      end

      it 'userはtweetしたユーザーであること' do
        expect(notification.user).to eq(tweet.user)
      end

      it 'action_typeがcommentであること' do
        expect(notification.action_type).to eq('comment')
      end
    end
  end
end
