class SendMessageJob < ApplicationJob
  queue_as :mailer

  def perform(message)
    ActionCable.server.broadcast "rooms:#{message.room.id}", {
      username: message.user.username,
      body: message.content,
      room_id: message.room.id
    }
  end
end