# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Message, type: :model do
  describe 'バリデーション' do
    let(:message) { FactoryBot.build(:message) }

    it 'メッセージが正しく作成されること' do
      expect(message).to be_valid
    end

    it 'メッセージがnilの場合にエラーとなること' do
      message.message = nil
      expect(message).not_to be_valid
    end

    it 'メッセージが100文字を超えるとエラーとなること' do
      message.message = 'a' * 101
      expect(message).not_to be_valid
    end
  end
end
