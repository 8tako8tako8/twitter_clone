require 'rails_helper'

RSpec.describe "Follows", type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'ユーザーをフォローする' do
    user1 = FactoryBot.create(:user)
    user2 = FactoryBot.create(:user)
    FactoryBot.create(:tweet, tweet: 'フォロー用', user: user2)

    visit root_path
    click_link 'ログイン'
    fill_in 'user[email]', with: user1.email
    fill_in 'user[password]', with: user1.password
    click_button 'ログインする'

    click_link 'フォロー用'

    find('button#dropdownMenuButton').click
    within('.dropdown-menu') do
      click_link "#{user2.user_name}をフォローする"
    end

    expect(page).to have_content 'フォローしました'
    expect(page).to have_content "#{user2.user_name}をフォロー解除"
  end

  it 'ユーザーをフォロー解除する' do
    user1 = FactoryBot.create(:user)
    user2 = FactoryBot.create(:user)
    user1.follow(user2)
    FactoryBot.create(:tweet, tweet: 'フォロー用', user: user2)

    visit root_path
    click_link 'ログイン'
    fill_in 'user[email]', with: user1.email
    fill_in 'user[password]', with: user1.password
    click_button 'ログインする'

    click_link 'フォロー用'

    expect(page).to have_content 'フォロー用'

    find('button#dropdownMenuButton').click
    within('.dropdown-menu') do
      click_link "#{user2.user_name}をフォロー解除"
    end

    expect(page).to have_content 'フォロー解除しました'
    expect(page).to have_content "#{user2.user_name}をフォローする"
  end
end
