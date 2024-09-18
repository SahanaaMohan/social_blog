class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  private
  def current_company
    return nil unless user_signed_in?
    @current_company ||= current_user.company
  end
  helper_method :current_company
 
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) do |user_params|
        user_params.permit(:name,
                           :email,
                           :username,
                           :password,
                           :password_confirmation
                          )
      end
    end
end
