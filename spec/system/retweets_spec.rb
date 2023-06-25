require 'rails_helper'

RSpec.describe "Retweets", type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'ユーザーがリツイートする' do
    user = FactoryBot.create(:user)
    tweet = FactoryBot.create(:tweet, tweet: 'リツイート用')

    visit root_path
    click_link 'ログイン'
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログインする'

    click_link 'リツイート用'

    expect(page).not_to have_css('.bi.bi-recycle.text-success')

    find('#retweet-link').click

    expect(page).to have_css('.bi.bi-recycle.text-success')
  end

  it 'ユーザーがリツイート解除する' do
    user = FactoryBot.create(:user)
    tweet = FactoryBot.create(:tweet, tweet: 'リツイート用')
    user.retweet(tweet)

    visit root_path
    click_link 'ログイン'
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログインする'

    click_link 'リツイート用'

    expect(page).to have_css('.bi.bi-recycle.text-success')

    find('#retweet-link').click

    expect(page).not_to have_css('.bi.bi-recycle.text-success')
  end
end
