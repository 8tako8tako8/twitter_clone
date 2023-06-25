require 'rails_helper'

RSpec.describe "Tweets", type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'ユーザーがツイートを投稿する' do
    user = FactoryBot.create(:user)

    visit root_path
    click_link 'ログイン'
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログインする'

    expect {
      fill_in 'tweet[tweet]', with: 'テストツイート'
      click_button 'ツイートする'

      expect(page).to have_content 'ツイートを投稿しました'
      expect(page).to have_content 'テストツイート'
    }
  end

  it 'ユーザーが画像付きツイートを投稿する' do
    user = FactoryBot.create(:user)

    visit root_path
    click_link 'ログイン'
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログインする'

    expect {
      fill_in 'tweet[tweet]', with: 'テストツイート'
      attach_file 'tweet[image]', 'spec/files/sky.jpg'
      click_button 'ツイートする'

      expect(page).to have_content 'ツイートを投稿しました'
      expect(page).to have_content 'テストツイート'
    }
  end
end
