require 'rails_helper'

describe 'GET api/sessions', type: :request do
  let(:user) { create(:user)}

  it 'returns current user' do
    auth_get '/api/sessions'
    expect(response_json["id"]).to eq current_user[:id]
  end

end
