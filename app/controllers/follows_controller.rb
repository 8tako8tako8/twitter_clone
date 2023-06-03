# frozen_string_literal: true

class FollowsController < ApplicationController
  before_action :authenticate_user!

  def create
    user = User.find(params[:user_id])
    current_user.follow(user)
    flash[:notice] = 'フォローしました'
    redirect_to request.referer || root_path
  end

  def destroy
    user = User.find(params[:user_id])
    current_user.unfollow(user)
    flash[:notice] = 'フォロー解除しました'
    redirect_to request.referer || root_path
  end
end
