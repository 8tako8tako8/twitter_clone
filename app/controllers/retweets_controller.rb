# frozen_string_literal: true

class RetweetsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User.find(params[:user_id])
    @retweets = @user.retweets.order(created_at: :desc).page(params[:page]).per(10)
  end

  def create
    tweet = Tweet.find(params[:tweet_id])
    current_user.retweet(tweet)
    redirect_to request.referer || root_path
  end

  def destroy
    tweet = Tweet.find(params[:tweet_id])
    current_user.unretweet(tweet)
    redirect_to request.referer || root_path
  end
end
