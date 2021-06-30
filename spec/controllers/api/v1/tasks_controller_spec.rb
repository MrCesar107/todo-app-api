# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::TasksController, type: :request do
  let(:user) { create_user }
  let(:chart) { create(:chart) }

  describe 'POST #create' do
    before do
      login_with_api user
      @request_url = "/api/v1/charts/#{chart.id}/tasks"
    end

    context 'When creating a new task' do
      it 'returns task JSON' do
        post @request_url,
             headers: { 'Authorization': response.headers['Authorization'] },
             params: {
               task: { name: 'Test', description: 'This is a test' }
             }

        expect(response.status).to eq 200
        expect(json['data']).to have_type 'tasks'
        expect(json['data']['attributes']['name']).to eq 'Test'
        expect(json['data']['attributes']['description']).to eq 'This is a test'
        expect(json['data']['attributes']['chart_id']).to eq chart.id
      end
    end

    context 'When task params is missing' do
      it 'returns a 400 status error' do
        post @request_url,
             headers: { 'Authorization': response.headers['Authorization'] },
             params: { task: { name: nil, description: nil } }

        expect(response.status).to eq 400
      end
    end
  end

  describe 'GET #index' do
    before do
      login_with_api user
      @request_url = "/api/v1/charts/#{chart.id}/tasks"
      create(:task, chart_id: chart.id)
      create(:task, chart_id: chart.id)
    end

    it 'returns task from a chart' do
      get @request_url,
          headers: { 'Authorization': response.headers['Authorization'] }

      expect(response.status).to eq 200
      expect(json['data'].count).to eq 2
    end
  end

  describe 'PUT #update' do
    before do
      login_with_api user
      subject = create(:task, chart_id: chart.id)
      @request_url = "/api/v1/charts/#{chart.id}/tasks/#{subject.id}"
    end

    it 'updates a task with given params' do
      put @request_url,
          headers: { 'Authorization': response.headers['Authorization'] },
          params: {
            task: { name: 'Change', description: 'Description has changed' }
          }

      expect(response.status).to eq 200
      expect(json['data']['attributes']['name']).to eq 'Change'
      expect(json['data']['attributes']['description']).to eq 'Description has changed'
      expect(json['data']['attributes']['chart_id']).to eq chart.id
    end

    context 'when task is not found' do
      before do
        @request_url = "/api/v1/charts/#{chart.id}/tasks/1277"
      end

      it 'returns 404 status' do
        put @request_url,
            headers: { 'Authorization': response.headers['Authorization'] },
            params: {
              task: { name: 'Change' }
            }

        expect(response.status).to eq 404
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      login_with_api user
      @subject = create(:task, chart_id: chart.id)
      @request_url = "/api/v1/charts/#{chart.id}/tasks/#{@subject.id}"
    end

    it 'doesnt find deleted record' do
      delete @request_url,
             headers: { 'Authorization': response.headers['Authorization'] }

      expect(response.status).to eq 200
      @subject.reload
      expect(@subject.status).to eq 'inactive'
    end

    context 'when task is not found' do
      before do
        @request_url = "/api/v1/charts/#{chart.id}/tasks/87302"
      end

      it 'returns 404 status' do
        put @request_url,
            headers: { 'Authorization': response.headers['Authorization'] }

        expect(response.status).to eq 404
      end
    end
  end
end
