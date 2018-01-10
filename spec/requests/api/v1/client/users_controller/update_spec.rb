require 'rails_helper'

describe 'PUT /api/users', type: :request do

  def valid_params
    {
      user: {
        email: "newemail@gmail.com"
      }
    }
  end

  def invalid_params
    {
      user: {
        email: ""
      }
    }
  end


  context 'successful update' do

    it 'updates user name' do
      auth_put "/api/users", valid_params
      expect(response_json["email"]).to eq valid_params[:user][:email]
    end

  end

  context 'unsuccessful update' do

    it 'returns uprocessable status' do
      auth_put "/api/users", invalid_params
      expect(response.status).to eq 422
    end

  end

end
