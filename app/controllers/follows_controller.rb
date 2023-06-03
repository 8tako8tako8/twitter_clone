# frozen_string_literal: true

class FollowsController < ApplicationController
  before_action :authenticate_user!

  def create
    user = User.find(params[:user_id])
    if current_user.id == user.id
      flash[:alert] = '自分自身をフォローできません'
    elsif current_user.followings.exists?(user.id)
      flash[:alert] = 'フォロー済みです'
    elsif current_user.follow(user)
      flash[:notice] = 'フォローしました'
    else
      flash[:alert] = 'フォローに失敗しました'
    end
    redirect_to request.referer || root_path
  end

  def destroy
    user = User.find(params[:user_id])
    if current_user.unfollow(user)
      flash[:notice] = 'フォロー解除しました'
    else
      flash[:alert] = 'フォロー解除に失敗しました'
    end
    redirect_to request.referer || root_path
  end
end
