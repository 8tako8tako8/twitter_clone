# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  describe 'バリデーション' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:tweet) { FactoryBot.create(:tweet) }

    it 'ブックマークが正しく作成されること' do
      let!(:bookmark) { FactoryBot.create(:bookmark) }

      expect(bookmark).to be_valid
    end

    it '同一ユーザーが同一ツイートを複数回ブックマークできないこと' do
      FactoryBot.create(:bookmark, user: user, tweet: tweet)
      duplicate_bookmark = FactoryBot.build(:bookmark, user: user, tweet: tweet)
      expect(duplicate_bookmark).not_to be_valid
    end
  end
end
