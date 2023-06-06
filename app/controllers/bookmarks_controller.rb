# frozen_string_literal: true

class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @bookmarks = current_user.bookmarks.order(created_at: :desc).page(params[:page]).per(10)
  end

  def create
    tweet = Tweet.find(params[:tweet_id])
    current_user.bookmark(tweet)
    redirect_to request.referer || root_path
  end

  def destroy
    tweet = Tweet.find(params[:tweet_id])
    current_user.unbookmark(tweet)
    redirect_to request.referer || root_path
  end
end
