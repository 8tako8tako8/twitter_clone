# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :identical_user, only: %i[edit update]

  def show
    @user = User.find(params[:id])
    @tweets = @user.tweets.order(created_at: :desc).page(params[:page]).per(10)
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

  def identical_user
    unless current_user.id == params[:id].to_i
      flash[:alert] = "アクセス権がありません。"
      redirect_to root_path
    end
  end
end
