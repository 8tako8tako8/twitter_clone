# frozen_string_literal: true

Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  root 'tweets#index'
  resources :users, only: [:show] do
    resources :favorites, only: [:index]
    resources :retweets, only: [:index]
    resources :comments, only: [:index]
    resource :follow, only: %i[create destroy]
    resource :room, only: %i[create show]
    resources :messages, only: [:create]
  end
  resource :user, only: %i[edit update], as: 'profile'
  resources :tweets, only: [:create]
  resources :tweets, only: [:show] do
    resources :comments, only: [:create]
    resource :favorite, only: %i[create destroy]
    resource :bookmark, only: %i[create destroy]
    resource :retweet, only: %i[create destroy]
  end
  resources :bookmarks, only: [:index]
  resources :rooms, only: [:index]
  resources :notifications, only: [:index]
end
