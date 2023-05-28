# frozen_string_literal: true

class CommentsController < ApplicationController
  def index
    return redirect_to root_path unless user_signed_in?
    return redirect_to root_path if params[:user_id].nil?

    @user = User.find(params[:user_id])
    @comments = @user.comments.order(created_at: :desc).page(params[:page]).per(10)
  end
end
