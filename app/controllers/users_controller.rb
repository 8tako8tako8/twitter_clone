class UsersController < ApplicationController
  def show
    return redirect_to root_path if !user_signed_in?

    @user = User.find(params[:id])
    case params[:view]
    when 'favorite'
      @favorites = Favorite.where(user_id: params[:id]).order(created_at: :desc).page(params[:page]).per(10)
    when 'retweet'
      @retweets = Retweet.where(user_id: params[:id]).order(created_at: :desc).page(params[:page]).per(10)
    when 'comment'
      @comments = Comment.where(user_id: params[:id]).order(created_at: :desc).page(params[:page]).per(10)
    else
      @tweets = Tweet.where(user_id: params[:id]).order(created_at: :desc).page(params[:page]).per(10)
    end
  end
end