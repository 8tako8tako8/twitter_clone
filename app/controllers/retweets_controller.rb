# frozen_string_literal: true

class RetweetsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User.find(params[:user_id])
    @retweets = @user.retweets.order(created_at: :desc).page(params[:page]).per(10)
  end
end