# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::WorkspacesController, type: :request do
  let(:user) { create_user }

  describe 'POST #create' do
    before do
      login_with_api user
      @request_url = '/api/v1/workspaces'
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
        expect(json['data']['attributes']['name']).to eq 'Test'
        expect(json['data']['attributes']['user_id']).to eq user.id
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
      @request_url = '/api/v1/workspaces'
      create(:workspace, user_id: user.id)
      create(:workspace, user_id: user.id)
    end

    it 'returns user workspaces' do
      get @request_url,
          headers: { 'Authorization': response.headers['Authorization'] }

      expect(response.status).to eq 200
      expect(json['data'].count).to eq 2
    end
  end

  describe 'PUT #update' do
    before do
      login_with_api user
      subject = create(:workspace, user_id: user.id)
      @request_url = "/api/v1/workspaces/#{subject.id}"
    end

    it 'updates a workspace with given params' do
      put @request_url,
          headers: { 'Authorization': response.headers['Authorization'] },
          params: {
            workspace: { name: 'Change' }
          }

      expect(response.status).to eq 200
      expect(json['data']['attributes']['name']).to eq 'Change'
      expect(json['data']['attributes']['user_id']).to eq user.id
    end

    context 'when workspace is not found' do
      before do
        @request_url = '/api/v1/workspaces/6503'
      end

      it 'returns 404 status' do
        put @request_url,
            headers: { 'Authorization': response.headers['Authorization'] },
            params: {
              workspace: { name: 'Change' }
            }

        expect(response.status).to eq 404
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      login_with_api user
      @subject = create(:workspace, user_id: user.id)
      @request_url = "/api/v1/workspaces/#{@subject.id}"
    end

    it 'doesnt find deleted record' do
      delete @request_url,
             headers: { 'Authorization': response.headers['Authorization'] }

      expect(response.status).to eq 200
      @subject.reload
      expect(@subject.status).to eq 'inactive'
    end

    context 'when workspace is not found' do
      before do
        @request_url = '/api/v1/workspaces/23493'
      end

      it 'returns 404 status' do
        put @request_url,
            headers: { 'Authorization': response.headers['Authorization'] },
            params: {
              workspace: { name: 'Change' }
            }

        expect(response.status).to eq 404
      end
    end
  end
end
