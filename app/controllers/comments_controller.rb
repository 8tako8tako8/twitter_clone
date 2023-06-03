# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User.find(params[:user_id])
    @comments = @user.comments.order(created_at: :desc).page(params[:page]).per(10)
  end

  def create
    @tweet = Tweet.find(params[:tweet_id])
    @comment = current_user.comment(comment_params[:comment], @tweet)

    if @comment.persisted?
      flash[:notice] = 'コメントを投稿しました。'
      redirect_to tweet_path(@tweet)
    else
      @comments = @tweet.comments.order(created_at: :asc).page(params[:page]).per(10)
      render 'tweets/show', status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
