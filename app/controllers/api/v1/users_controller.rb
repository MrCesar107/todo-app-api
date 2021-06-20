# frozen_string_literal: true

module Api
  module V1
    class UsersController < BaseController
      before_action :user, only: %w[show]

      def show
        api_response(user)
      end

      private

      def user
        @user ||= User.find params[:id]
      end
    end
  end
end
