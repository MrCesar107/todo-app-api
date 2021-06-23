# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::Users::WorkspacesController, type: :request do
  let(:user) { create_user }

  describe 'POST #create' do
    before do
      login_with_api user
      @request_url = "/api/v1/users/#{user.id}/workspaces"
    end

    context 'When creating a new workspace' do
      it 'returns workspace JSON' do
        post @request_url,
             headers: { 'Authorization': response.headers['Authorization'] },
             params: {
               workspace: { name: 'Test' }
             }

        expect(response.status).to eq 200
        expect(json['data']).to have_type 'workspaces'
      end
    end

    context 'When workspace params is missing' do
      it 'returns a 400 status error' do
        post @request_url,
             headers: { 'Authorization': response.headers['Authorization'] },
             params: { workspace: { name: nil } }

        expect(response.status).to eq 400
      end
    end
  end

  describe 'GET #index' do
    before do
      login_with_api user
      @request_url = "/api/v1/users/#{user.id}/workspaces"
      create(:workspace, user_id: user.id)
      create(:workspace, user_id: user.id)
    end

    it 'returns 200 status' do
      get @request_url,
          headers: { 'Authorization': response.headers['Authorization'] }

      expect(response.status).to eq 200
    end

    it 'returns user workspaces' do
      get @request_url,
          headers: { 'Authorization': response.headers['Authorization'] }

      expect(json['data'].count).to eq 2
    end
  end
end
