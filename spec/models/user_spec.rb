# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーション' do
    context '通常の会員登録で作成された場合' do
      subject(:user) { FactoryBot.build(:user) }

      it 'ユーザー名がnilの時にエラーとなること' do
        user.user_name = nil
        expect(user).not_to be_valid
      end

      it '電話番号がnilの時にエラーとなること' do
        user.tel = nil
        expect(user).not_to be_valid
      end

      it '生年月日がnilの時にエラーとなること' do
        user.birthdate = nil
        expect(user).not_to be_valid
      end

      it 'WebサイトURLのフォーマットが正しくない時にエラーになること' do
        user.website_url = 'invalid_url'
        expect(user).not_to be_valid
      end

      it 'WebサイトURLが空文字の時に正しく作成されること' do
        user.website_url = ''
        expect(user).to be_valid
      end
    end

    context 'GitHub認証で作成された場合' do
      subject(:user) { FactoryBot.build(:user, :github) }

      it 'ユーザー名がnilの時に正しく作成されること' do
        user.user_name = nil
        expect(user).to be_valid
      end

      it '電話番号がnilの時に正しく作成されること' do
        user.tel = nil
        expect(user).to be_valid
      end

      it '生年月日がnilの時に正しく作成されること' do
        user.birthdate = nil
        expect(user).to be_valid
      end

      it 'uidとproviderの組み合わせが重複している時にエラーとなること' do
        FactoryBot.create(:user, :github, uid: user.uid)
        expect(user).not_to be_valid
      end
    end
  end

  describe '#follow' do
    let(:user) { FactoryBot.create(:user) }
    let(:other_user) { FactoryBot.create(:user) }

    it 'フォローが正しくされること' do
      user.follow(other_user)
      expect(user.followings).to include(other_user)
    end
  end

  describe '#unfollow' do
    let(:user) { FactoryBot.create(:user) }
    let(:other_user) { FactoryBot.create(:user) }

    it 'フォロー解除が正しくされること' do
      user.follow(other_user)
      user.unfollow(other_user)
      expect(user.followings).not_to include(other_user)
    end
  end

  describe '#favorite' do
    let(:user) { FactoryBot.create(:user) }
    let(:tweet) { FactoryBot.create(:tweet) }

    it 'いいねが正しくされること' do
      user.favorite(tweet)
      expect(user.favorites.map(&:tweet)).to include(tweet)
    end
  end

  describe '#unfavorite' do
    let(:user) { FactoryBot.create(:user) }
    let(:tweet) { FactoryBot.create(:tweet) }

    it 'いいね解除が正しくされること' do
      user.favorite(tweet)
      user.unfavorite(tweet)
      expect(user.favorites.map(&:tweet)).not_to include(tweet)
    end
  end

  describe '#retweet' do
    let(:user) { FactoryBot.create(:user) }
    let(:tweet) { FactoryBot.create(:tweet) }

    it 'リツイートが正しくされること' do
      user.retweet(tweet)
      expect(user.retweets.map(&:tweet)).to include(tweet)
    end
  end

  describe '#unretweet' do
    let(:user) { FactoryBot.create(:user) }
    let(:tweet) { FactoryBot.create(:tweet) }

    it 'リツイート解除が正しくされること' do
      user.retweet(tweet)
      user.unretweet(tweet)
      expect(user.retweets.map(&:tweet)).not_to include(tweet)
    end
  end

  describe '#comment' do
    let(:user) { FactoryBot.create(:user) }
    let(:tweet) { FactoryBot.create(:tweet) }

    it 'コメントが正しくされること' do
      user.comment('テストコメント', tweet)
      expect(user.comments.map(&:tweet)).to include(tweet)
    end
  end

  describe '#bookmark' do
    let(:user) { FactoryBot.create(:user) }
    let(:tweet) { FactoryBot.create(:tweet) }

    it 'ブックマークが正しくされること' do
      user.bookmark(tweet)
      expect(user.bookmarks.map(&:tweet)).to include(tweet)
    end
  end

  describe '#unbookmark' do
    let(:user) { FactoryBot.create(:user) }
    let(:tweet) { FactoryBot.create(:tweet) }

    it 'ブックマーク解除が正しくされること' do
      user.unbookmark(tweet)
      expect(user.bookmarks.map(&:tweet)).not_to include(tweet)
    end
  end

  describe '#room' do
    let!(:user1) { FactoryBot.create(:user) }
    let!(:user2) { FactoryBot.create(:user) }

    context '共通のルームが存在しなかった場合' do
      it '新しいルームが作成されること' do
        expect { user1.room(user2) }.to change(Room, :count).by(1)
      end
    end

    context '共通のルームが存在した場合' do
      let!(:room) { Room.create }

      before do
        room.entries.create(user_id: user1.id)
        room.entries.create(user_id: user2.id)
      end

      it '共通のルームが返されること' do
        expect(user1.room(user2)).to eq(room)
      end
    end
  end

  describe '#common_room' do
    let!(:user1) { FactoryBot.create(:user) }
    let!(:user2) { FactoryBot.create(:user) }

    context '共通のルームが存在しなかった場合' do
      it 'nilが返されること' do
        expect(user1.common_room(user2)).to be_nil
      end
    end

    context '共通のルームが存在した場合' do
      let!(:room) { Room.create }

      before do
        room.entries.create(user_id: user1.id)
        room.entries.create(user_id: user2.id)
      end

      it '共通のルームが返されること' do
        expect(user1.common_room(user2)).to eq(room)
      end
    end
  end
end
