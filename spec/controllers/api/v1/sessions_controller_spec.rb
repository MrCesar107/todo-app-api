# frozen_string_literal: true

require 'rails_helper'

describe 'SessionsController', type: :request do
  let(:user) { create_user }

  context 'when logging in' do
    before do
      login_with_api(user)
    end

    it 'returns a valid token' do
      expect(response.headers['Authorization']).to be_present
    end

    it 'returns 200' do
      expect(response.status).to eq 200
    end
  end

  context 'when password is missing' do
    before do
      post '/api/v1/login', params: { user: { email: user.email, password: nil } }
    end

    it 'returns 401' do
      expect(response.status).to eq 401
    end
  end

  context 'when logging out' do
    it 'returns 204' do
      delete '/api/v1/logout'

      expect(response).to have_http_status(204)
    end
  end
end
