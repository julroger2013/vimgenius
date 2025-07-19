class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :create_temp_user

  authem_for :user

  # Decent Exposure 3.0 uses default strong parameters strategy

  def create_temp_user
    unless user_signed_in?
      sign_in(User.create_temporary)
    end
  end


end
