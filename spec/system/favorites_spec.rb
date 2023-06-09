# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Favorites', type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'ユーザーがいいねする' do
    user = FactoryBot.create(:user)
    FactoryBot.create(:tweet, tweet: 'いいね用')

    visit root_path
    click_link 'ログイン'
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログインする'

    click_link 'いいね用'

    expect(page).to have_css('[data-testid="favorite-link"]')

    find('[data-testid="favorite-link"]').click

    expect(page).to have_css('[data-testid="unfavorite-link"]')
  end

  it 'ユーザーがいいね解除する' do
    user = FactoryBot.create(:user)
    tweet = FactoryBot.create(:tweet, tweet: 'いいね用')
    user.favorite(tweet)

    visit root_path
    click_link 'ログイン'
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログインする'

    click_link 'いいね用'

    expect(page).to have_css('[data-testid="unfavorite-link"]')

    find('[data-testid="unfavorite-link"]').click

    expect(page).to have_css('[data-testid="favorite-link"]')
  end
end
