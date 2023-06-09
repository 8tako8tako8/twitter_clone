# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Bookmarks', type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'ユーザーがブックマークする' do
    user = FactoryBot.create(:user)
    FactoryBot.create(:tweet, tweet: 'ブックマーク用')

    visit root_path
    click_link 'ログイン'
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログインする'

    click_link 'ブックマーク用'

    find('[data-testid="bookmark-link"]').click

    expect(page).to have_css('[data-testid="unbookmark-link"]')
  end

  it 'ユーザーがブックマーク解除する' do
    user = FactoryBot.create(:user)
    tweet = FactoryBot.create(:tweet, tweet: 'ブックマーク用')
    user.bookmark(tweet)

    visit root_path
    click_link 'ログイン'
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログインする'

    click_link 'ブックマーク用'

    find('[data-testid="unbookmark-link"]').click
    find('[data-testid="bookmark-link"]').click

    expect(page).to have_css('[data-testid="unbookmark-link"]')
  end
end
