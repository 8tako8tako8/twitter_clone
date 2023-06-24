require 'rails_helper'

RSpec.describe Room, type: :model do
  describe '#message' do
    let(:user) { FactoryBot.create(:user) }
    let(:room) { FactoryBot.create(:room) }
    let(:message_params) { { message: "テストメッセージ" } }

    it 'メッセージが正しく作成されること' do
      message = room.message(user, message_params)
      expect(message).to be_valid
      expect(message.user).to eq(user)
      expect(message.room).to eq(room)
      expect(message.message).to eq("テストメッセージ")
    end
  end
end
