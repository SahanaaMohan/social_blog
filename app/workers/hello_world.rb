# hello-scheduler.rb

require 'sidekiq-scheduler'

class HelloWorld
  include Sidekiq::Worker

  def perform
    puts 'Hello new world'
  end
end