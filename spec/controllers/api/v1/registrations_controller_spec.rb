# frozen_string_literal: true

require 'rails_helper'

describe 'RegistrationsController', type: :request do
  let(:user) { build_user }
  let(:existing_user) { create_user }

  context 'when creating a new user' do
    before do
      post '/api/v1/signup', params: { user: { name: user.name, username: user.username,
                                               email: user.email, password: user.password } }
    end

    it 'returns 200' do
      expect(response.status).to eq 200
    end

    it 'returns a valid token' do
      expect(response.headers['Authorization']).to be_present
    end

    it 'returns the user email' do
      expect(json['data']).to have_attribute(:email).with_value user.email
    end
  end

  context 'when an email already exists' do
    before do
      post '/api/v1/signup', params: { user: { name: existing_user.name, username: existing_user.username,
                                               email: existing_user.email, password: existing_user.password } }
    end

    it 'returns 400' do
      expect(response.status).to eq 400
    end
  end
end
