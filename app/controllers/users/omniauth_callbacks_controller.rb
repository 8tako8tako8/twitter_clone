# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    skip_before_action :verify_authenticity_token, only: :github

    def github
      @user = User.from_omniauth(request.env['omniauth.auth'])

      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'github') if is_navigational_format?
    rescue StandardError => e
      session['devise.github_data'] = request.env['omniauth.auth'].except(:extra)
      flash[:alert] = e.message
      redirect_to new_user_registration_url
    end

    def failure
      redirect_to root_path
    end
  end
end
