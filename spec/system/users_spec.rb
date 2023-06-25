# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'プロフィールを更新する' do
    user = FactoryBot.create(:user)

    visit root_path
    click_link 'ログイン'
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログインする'

    click_link 'プロフィール'

    expect(page).to have_content('プロフィールを編集')

    click_link 'プロフィールを編集'

    fill_in 'user[introduction]', with: 'テスト自己紹介'
    fill_in 'user[location]', with: 'テスト所在地'
    fill_in 'user[website_url]', with: 'https://test2.example.com'
    fill_in 'user[birthdate]', with: '2000/01/01'

    click_button '保存'

    expect(page).to have_content('変更を保存しました。')
    expect(page).to have_content('テスト自己紹介')
    expect(page).to have_content('テスト所在地')
    expect(page).to have_content('https://test2.example.com')
    expect(page).to have_content('2000-01-01')
  end
end
