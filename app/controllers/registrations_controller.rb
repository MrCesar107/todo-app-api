# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  def create
    build_resource user_params
    resource.save
    sign_up resource_name, resource if resource.persisted?

    api_response(resource)
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :email, :password)
  end
end
