class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room

  def create
    message = @room.messages.new(message_params)
    message.user = current_user
    message.save
    #SendMessageJob.perform_now(message)
    redirect_to room_path(@room.id)
    # end
  end

  def show
    message = @room.messages.all
  end

  private

    def set_room
      @room = Room.find(params[:room_id])
    end

    def message_params
      params.require(:message).permit(:content)
    end
end