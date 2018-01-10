require 'rails_helper'

describe 'PATCH /api/users/forgot_password', type: :request do

  let!(:user) { User.create first_name: 'foo', last_name: 'foor', email: 'foo@test.com', password: 'foo'}


  context 'successful forgot_password' do
    before do
      auth_patch "/api/users/forgot_password", email:user[:email]
    end

    it 'returns status 200' do
      expect(response.status).to eq 200
    end

    it 'sets reset_password_token' do
      expect(user.reload.reset_password_token).not_to eq nil
    end

  end

  context 'unsuccessful password changed' do

    it 'returns uprocessable status' do
      auth_patch "/api/users/forgot_password", email:'invalid@email.com'
      expect(response_json['error']).to eq 'Email address does not match any account'
    end

  end

end
