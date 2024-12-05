# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # POST /resource
  def create
    super do |resource|
      if resource.persisted?
        return redirect_to new_user_session_path,
                           notice: "Account creation successful. Sign in to continue"
      end
    end
  end
end
