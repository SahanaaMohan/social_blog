# controllers/admins/sessions_controller.rb
class Admins::SessionsController < Devise::SessionsController
  include Accessible
  skip_before_action :check_resource, only: :destroy
end