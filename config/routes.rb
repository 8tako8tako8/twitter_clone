# frozen_string_literal: true

Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  resources :users, only: [:show]
  resources :favorites, only: [:index]
  resources :retweets, only: [:index]
  resources :comments, only: [:index]
  root 'tweets#index'
end
