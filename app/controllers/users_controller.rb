# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    return redirect_to root_path unless user_signed_in?

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

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = '変更を保存しました。'
      redirect_to user_path(@user)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:header_image, :image, :introduction, :location, :website_url, :birthdate)
  end
end
