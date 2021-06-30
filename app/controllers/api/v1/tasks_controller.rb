# frozen_string_literal: true

module Api
  module V1
    class TasksController < ::Api::V1::BaseController # :nodoc:
      def create
        task = Task.new task_params

        if task.valid? && task.save
          api_response task
        else
          render json: { error: task.errors }, status: :bad_request
        end
      end

      def index
        render jsonapi: tasks, status: :ok
      end

      def update
        if task.update(task_params) && task.valid?
          api_response task
        else
          render json: { error: task.errors }, status: :bad_request
        end
      end

      def destroy
        if task.update status: 'inactive'
          api_response task
        else
          render json: { error: task.errors }, status: :bad_request
        end
      end

      private

      def tasks
        @tasks ||= chart.tasks
      end

      def task
        @task ||= Task.find params[:id]
      end

      def chart
        @chart ||= Chart.find params[:chart_id]
      end

      def task_params
        params.require(:task)
              .permit(:name, :description)
              .merge(chart_id: chart.id)
      end
    end
  end
end
