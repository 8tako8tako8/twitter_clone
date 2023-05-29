# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User.find(params[:user_id])
    @comments = @user.comments.order(created_at: :desc).page(params[:page]).per(10)
  end

  def create
    tweet = Tweet.find(params[:id])
    current_user.comment(comment_params, tweet)
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
