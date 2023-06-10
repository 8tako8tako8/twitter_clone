# frozen_string_literal: true

class RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = search_users
  end

  def create
    user = User.find(params[:user_id])
    current_user.room(user)
    redirect_to user_room_path(user)
  end

  def show
    @users = search_users
    @user = User.find(params[:user_id])
    @room = current_user.common_room(@user)
    @message = Message.new
  end

  private

  def entry_params
    params.require(:entry).permit(:user_id, :room_id)
  end

  def search_users
    User.joins(:entries).where(entries: { room: current_user.rooms }).where.not(id: current_user.id).order(created_at: :asc).page(params[:page]).per(10)
  end
end
