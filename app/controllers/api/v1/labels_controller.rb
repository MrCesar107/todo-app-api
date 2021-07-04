# frozen_string_literal: true

module Api
  module V1
    class LabelsController < ::Api::V1::BaseController # :nodoc:
      def create
        label = Label.new label_params

        if label.valid? && label.save
          api_response label
        else
          render json: { error: label.errors }, status: :bad_request
        end
      end

      def index
        render jsonapi: labels, status: :ok
      end

      def update
        if label.update(label_params) && label.valid?
          api_response label
        else
          render json: { error: label.errors }, status: :bad_request
        end
      end

      def destroy
        label.delete
        render json: { message: 'Label was deleted successfully' },
               status: :ok
      end

      private

      def label
        @label ||= Label.find params[:id]
      end

      def label_params
        params.require(:label)
              .permit(:name, :color)
              .merge(user_id: current_user.id)
      end

      def labels
        @labels ||= current_user.labels
      end
    end
  end
end
