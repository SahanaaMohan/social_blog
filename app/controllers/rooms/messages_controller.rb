class Rooms::MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room

  def create
    message = @room.messages.new(message_params,context)
    message.user = current_user
    message.save
    #SendMessageJob.perform_later(message.to_json)
  end

  private

    def set_room
      @room = Room.find(params[:room_id])
    end

    def message_params
      params.require(:message).permit(:content)
    end
end