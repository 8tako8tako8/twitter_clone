# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    return redirect_to root_path unless user_signed_in?

    @user = User.find(params[:id])
    @tweets = @user.tweets.order(created_at: :desc).page(params[:page]).per(10)
  end
end
