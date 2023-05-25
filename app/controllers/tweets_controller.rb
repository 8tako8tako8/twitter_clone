# frozen_string_literal: true

class TweetsController < ApplicationController
  def index
    case params[:view]
    when 'follow'
      # フォローしているユーザーのツイート一覧
      followed_user_ids = current_user.followings.pluck(:followed_user_id)
      @tweets = Tweet.where(user_id: followed_user_ids).order(created_at: :desc).page(params[:page]).per(10)
    else
      # 全てのツイート一覧
      @tweets = Tweet.all.order(created_at: :desc).page(params[:page]).per(10)
    end
  end
end
