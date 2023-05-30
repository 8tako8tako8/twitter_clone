# frozen_string_literal: true

class TweetsController < ApplicationController
  def index
    @tweet = Tweet.new
    case params[:view]
    when 'follow'
      followed_user_ids = current_user.followings.pluck(:followed_user_id)
      @tweets = Tweet.where(user_id: followed_user_ids).order(created_at: :desc).page(params[:page]).per(10)
    else
      @tweets = Tweet.all.order(created_at: :desc).page(params[:page]).per(10)
    end
  end

  def create
    @tweet = current_user.tweets.build(tweet_params)
    if @tweet.save
      flash[:notice] = 'ツイートを投稿しました'
      redirect_to root_path
    else
      @tweets = Tweet.all.order(created_at: :desc).page(params[:page]).per(10)
      render 'index', status: :unprocessable_entity
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:tweet, :image)
  end
end
