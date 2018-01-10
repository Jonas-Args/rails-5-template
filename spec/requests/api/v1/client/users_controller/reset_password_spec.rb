require 'rails_helper'

describe 'PATCH /users/reset_password' do

  let!(:user) { User.create first_name: 'foo', last_name: 'foor', email: 'foo@test.com', password: 'foo', reset_password_token: 'foo123'}

  let(:valid_params) do {
      token: 'foo123',
      password: '12345678'
    }
  end

  let(:invalid_params) do {
      token: 'foo12345',
      password: 'test123'
    }
  end

  context 'valid' do
    it 'returns status 204' do
      auth_patch "/api/users/reset_password", valid_params
      expect(response.status).to eq 200
    end

    it 'updates the user record' do
      expect {
        auth_patch "/api/users/reset_password", valid_params
      }.to change { user.reload.reset_password_token }.to eq nil
    end
  end

  context 'invalid' do
    it 'authentication failed' do
      auth_patch "/api/users/reset_password", invalid_params
      expect(response.status).to eq 401
    end
  end

end
