# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Messages', type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'ユーザーがメッセージを送信する' do
    user1 = FactoryBot.create(:user)
    user2 = FactoryBot.create(:user)
    FactoryBot.create(:tweet, tweet: 'メッセージ用', user: user2)

    visit root_path
    click_link 'ログイン'
    fill_in 'user[email]', with: user1.email
    fill_in 'user[password]', with: user1.password
    click_button 'ログインする'

    find("#profile-link-#{user2.id}").click
    find('#room-link').click

    expect(page).to have_content 'メッセージ'
    expect(page).to have_content user2.user_name.to_s

    fill_in 'message[message]', with: 'テストメッセージ'
    click_button '送信'

    expect(page).to have_content 'テストメッセージ'
  end
end
