# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::LabelsController, type: :request do
  let(:user) { create_user }
  let(:other_user) { create_user }

  describe 'POST #create' do
    before do
      login_with_api user
      @request_url = '/api/v1/labels'
    end

    context 'When create a label' do
      it 'returns label JSON' do
        post @request_url,
             headers: { 'Authorization': response.headers['Authorization'] },
             params: {
               label: { name: 'Important', color: '#22DD22' }
             }

        expect(response.status).to eq 200
        expect(json['data']).to have_type 'labels'
        expect(json['data']['attributes']['name']).to eq 'Important'
        expect(json['data']['attributes']['color']).to eq '#22DD22'
        expect(json['data']['attributes']['user_id']).to eq user.id
      end
    end

    context 'When label params are missing' do
      it 'returns a 400 status error' do
        post @request_url,
             headers: { 'Authorization': response.headers['Authorization'] },
             params: { label: { name: nil, color: nil } }

        expect(response.status).to eq 400
      end
    end
  end

  describe 'GET #index' do
    before do
      login_with_api user
      @request_url = '/api/v1/labels'
      create(:label, user_id: user.id)
      create(:label, user_id: user.id)
    end

    it 'returns users labels' do
      get @request_url,
          headers: { 'Authorization': response.headers['Authorization'] }

      expect(response.status).to eq 200
      expect(json['data'].count).to eq 2
    end

    context 'When user has no labels' do
      before do
        login_with_api other_user
        @request_url = '/api/v1/labels'
        get @request_url,
            headers: { 'Authorization': response.headers['Authorization'] }
      end

      it { expect(response.status).to eq 200 }
      it { expect(json['data']).to eq [] }
    end
  end

  describe 'PUT #update' do
    before do
      login_with_api user
      subject = create(:label, user_id: user.id)
      @request_url = "/api/v1/labels/#{subject.id}"
    end

    it 'updates a label with given params' do
      put @request_url,
          headers: { 'Authorization': response.headers['Authorization'] },
          params: {
            label: { name: 'Change', color: '#dds20d' }
          }

      expect(response.status).to eq 200
      expect(json['data']['attributes']['name']).to eq 'Change'
      expect(json['data']['attributes']['color']).to eq '#dds20d'
      expect(json['data']['attributes']['user_id']).to eq user.id
    end

    context 'when label is not found' do
      it 'returns 404 status' do
        request_url = '/api/v1/labels/1277'
        put request_url,
            headers: { 'Authorization': response.headers['Authorization'] },
            params: {
              label: { name: 'Change', color: '#ffffff' }
            }

        expect(response.status).to eq 404
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      login_with_api user
      subject = create(:label, user_id: user.id)
      @request_url = "/api/v1/labels/#{subject.id}"
    end

    it 'returns a 200 status and confirm message' do
      delete @request_url,
             headers: { 'Authorization': response.headers['Authorization'] }

      expect(response.status).to eq 200
      expect(json['message']).to eq 'Label was deleted successfully'
    end

    context 'When label is not found' do
      it 'returns 404 status' do
        request_url = '/api/v1/labels/4635'
        delete request_url,
               headers: { 'Authorization': response.headers['Authorization'] }

        expect(response.status).to eq 404
      end
    end
  end
end
