# frozen_string_literal: true

module Api
  module V1
    module Users
      class WorkspacesController < ::Api::V1::BaseController # :nodoc:
        def create
          workspace = Workspace.new workspace_params

          if workspace.valid? && workspace.save
            api_response workspace
          else
            render json: { error: workspace.errors }, status: :bad_request
          end
        end

        def index
          render jsonapi: workspaces, status: :ok
        end

        private

        def workspace_params
          params.require(:workspace).permit(:name)
                .merge(user_id: current_user.id)
        end

        def workspaces
          @workspaces ||= current_user.workspaces
        end
      end
    end
  end
end
