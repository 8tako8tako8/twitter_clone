# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(params[:user_id])
    @room = current_user.common_room(@user)
    @message = @room.messages.build(message_params)
    @message.user_id = current_user.id
    if @message.save
      redirect_to user_room_path(@user)
    else
      @users = User.joins(:entries).where(entries: { room: current_user.rooms }).where.not(id: current_user.id).page(params[:page]).per(10)
      render 'rooms/show', status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:message)
  end
end
