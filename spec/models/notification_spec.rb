require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe '#send_email' do
    let!(:user) { FactoryBot.create(:user) }

    context 'リツイートの場合' do
      it 'リツイート通知メールが送信されること' do
        retweet = FactoryBot.create(:retweet, user: user)

        mail = ActionMailer::Base.deliveries.last
        expect(mail.subject).to eq 'リツイートのお知らせ'
        expect(mail.to).to eq [retweet.tweet.user.email]
      end
    end

    context 'お気に入りの場合' do
      it 'お気に入り通知メールが送信されること' do
        favorite = FactoryBot.create(:favorite, user: user)

        mail = ActionMailer::Base.deliveries.last
        expect(mail.subject).to eq 'いいねのお知らせ'
        expect(mail.to).to eq [favorite.tweet.user.email]
      end
    end

    context 'コメントの場合' do
      it 'コメント通知メールが送信されること' do
        comment = FactoryBot.create(:comment, user: user)

        mail = ActionMailer::Base.deliveries.last
        expect(mail.subject).to eq 'コメントのお知らせ'
        expect(mail.to).to eq [comment.tweet.user.email]
      end
    end
  end
end
