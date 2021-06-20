# frozen_string_literal: true

module Api
  module V1
    class BaseController < ::ApplicationController
      before_action :authenticate_user!

      rescue_from ActiveRecord::RecordNotFound, with: :not_found

      def not_found
        render json: {
          'errors': [
            {
              'status': '404',
              'title': 'Not found'
            }
          ]
        }, status: 404
      end
    end
  end
end
