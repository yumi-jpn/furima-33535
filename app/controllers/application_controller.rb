class ApplicationController < ActionController::Base
  before_action :authenticate_user!, only: [:new, :create]
  before_action :configure_permitted_parameters, if: :devise_controller?

  def index
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [:nickname, :last_name, :first_name, :last_name_kana, :first_name_kana, :birth_date])
  end
end
