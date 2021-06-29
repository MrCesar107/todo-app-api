# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::ChartsController, type: :request do
  let(:user) { create_user }
  let(:workspace) { create(:workspace, user_id: user.id) }

  describe 'POST #create' do
    before do
      login_with_api user
      @request_url = "/api/v1/workspaces/#{workspace.id}/charts"
    end

    context 'When creating a new chart' do
      it 'returns chart JSON' do
        post @request_url,
             headers: { 'Authorization': response.headers['Authorization'] },
             params: {
               chart: { name: 'Test', description: 'This is a test' }
             }

        expect(response.status).to eq 200
        expect(json['data']).to have_type 'charts'
        expect(json['data']['attributes']['name']).to eq 'Test'
        expect(json['data']['attributes']['description']).to eq 'This is a test'
        expect(json['data']['attributes']['workspace_id']).to eq workspace.id
      end
    end

    context 'When chart params is missing' do
      it 'returns a 400 status error' do
        post @request_url,
             headers: { 'Authorization': response.headers['Authorization'] },
             params: { chart: { name: nil, description: nil } }

        expect(response.status).to eq 400
      end
    end
  end

  describe 'GET #index' do
    before do
      login_with_api user
      @request_url = "/api/v1/workspaces/#{workspace.id}/charts"
      create(:chart, workspace_id: workspace.id)
      create(:chart, workspace_id: workspace.id)
    end

    it 'returns charts from a workspace' do
      get @request_url,
          headers: { 'Authorization': response.headers['Authorization'] }

      expect(response.status).to eq 200
      expect(json['data'].count).to eq 2
    end
  end

  describe 'PUT #update' do
    before do
      login_with_api user
      subject = create(:chart, workspace_id: workspace.id)
      @request_url = "/api/v1/workspaces/#{workspace.id}/charts/#{subject.id}"
    end

    it 'updates a chart with given params' do
      put @request_url,
          headers: { 'Authorization': response.headers['Authorization'] },
          params: {
            chart: { name: 'Change', description: 'Description has changed' }
          }

      expect(response.status).to eq 200
      expect(json['data']['attributes']['name']).to eq 'Change'
      expect(json['data']['attributes']['description']).to eq 'Description has changed'
      expect(json['data']['attributes']['workspace_id']).to eq workspace.id
    end

    context 'when chart is not found' do
      before do
        @request_url = "/api/v1/workspaces/#{workspace.id}/charts/202"
      end

      it 'returns 404 status' do
        put @request_url,
            headers: { 'Authorization': response.headers['Authorization'] },
            params: {
              chart: { name: 'Change' }
            }

        expect(response.status).to eq 404
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      login_with_api user
      @subject = create(:chart, workspace_id: workspace.id)
      @request_url = "/api/v1/workspaces/#{workspace.id}/charts/#{@subject.id}"
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
        @request_url = "/api/v1/workspaces/#{workspace.id}/charts/23493"
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
