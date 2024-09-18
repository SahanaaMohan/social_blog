class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_#{params[:room_id]}channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def get_user_data
    user = {
      id: current_user.id,
      email: current_user.email,
      username: current_user.email.split('@')[0]
    }
    puts params[:room_id]
    ActionCable.server.broadcast "room_channel", { user: }
  end
end