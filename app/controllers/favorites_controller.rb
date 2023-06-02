# frozen_string_literal: true

class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User.find(params[:user_id])
    @favorites = @user.favorites.order(created_at: :desc).page(params[:page]).per(10)
  end

  def create
    tweet = Tweet.find(params[:tweet_id])
    current_user.favorite(tweet)
    redirect_to request.referer || root_path
  end

  def destroy
    tweet = Tweet.find(params[:tweet_id])
    favorite = current_user.favorites.find_by(tweet_id: tweet.id)
    favorite.destroy
    redirect_to request.referer || root_path
  end
end
