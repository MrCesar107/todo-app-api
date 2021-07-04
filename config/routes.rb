# frozen_string_literal: true

Rails.application.routes.default_url_options[:host] = 'localhost:3000'

# rubocop:disable Metrics/BlockLength
Rails.application.routes.draw do
  devise_for(
    :users,
    defaults: { format: :json },
    path: '',
    path_names: {
      sign_in: 'api/v1/login',
      sign_out: 'api/v1/logout',
      registration: 'api/v1/signup'
    },
    controllers: {
      sessions: 'sessions',
      registrations: 'registrations'
    }
  )

  namespace :api do
    namespace :v1, defaults: { format: :json } do
      resources :users, only: %w[show]
      resources :workspaces do
        resources :charts
      end
      resources :charts do
        resources :tasks
      end
      resources :labels
    end
  end
end
# rubocop:enable Metrics/BlockLength
