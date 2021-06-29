# frozen_string_literal: true

module Api
  module V1
    class ChartsController < ::Api::V1::BaseController # :nodoc:
      def create
        chart = Chart.new chart_params

        if chart.valid? && chart.save
          api_response chart
        else
          render json: { error: chart.errors }, status: :bad_request
        end
      end

      def index
        render jsonapi: charts, status: :ok
      end

      def update
        if chart.update(chart_params) && chart.valid?
          api_response chart
        else
          render json: { error: chart.errors }, status: :bad_request
        end
      end

      def destroy
        if chart.update status: 'inactive'
          api_response chart
        else
          render json: { error: chart.errors }, status: :bad_request
        end
      end

      private

      def charts
        @charts ||= workspace.charts
      end

      def chart
        @chart ||= Chart.find params[:id]
      end

      def workspace
        @workspace ||= Workspace.find params[:workspace_id]
      end

      def chart_params
        params.require(:chart)
              .permit(:name, :description)
              .merge(workspace_id: workspace.id)
      end
    end
  end
end
