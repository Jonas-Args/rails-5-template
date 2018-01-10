
require 'rails_helper'

describe 'POST /api/sessions', type: :request do
  describe 'using valid params' do
    def valid_user_params
      {
        email: 'foo@bar.com',
        password: 'sourcepad'
      }
    end

    it 'logged in' do
      user = User.new(email: 'foo@bar.com', password: 'sourcepad')
      user.save(validate: false)
      auth_post '/api/sessions/', user: valid_user_params
      expect(response_json['email']).to eq valid_user_params[:email]
    end
  end

  describe 'using invalid params' do
    context 'email' do
      it 'doesn\'t match' do
        user = User.new(email: 'foo@bar.com', password: 'sourcepad')
        user.save(validate: false)
        auth_post '/api/sessions/', user: {email: 'wrong_email@bar.com', password: 'sourcepad'}
        expect(response_json['error']).to eq "Your email and password don't match"
      end
    end

    context 'password' do
      it 'doesn\'t match' do
        user = User.new(email: 'foo@bar.com', password: 'sourcepad')
        user.save(validate: false)
        auth_post '/api/sessions/', user: {email: 'foo@bar.com', password: 'wrong_password'}
        expect(response_json['error']).to eq "Your email and password don't match"
      end
    end
  end

end
