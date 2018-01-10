require 'rails_helper'

describe 'DELETE api/sessions', type: :request do
  let!(:user) { create(:user) }

  context 'success' do
    before do
      user.set_access_token
      delete "/api/sessions?access_token=#{user.current_token}"
    end

    it 'returns success status' do
      expect(response.status).to eq 200
    end

    it 'returns success message' do
      expect(response_json["success"]).to be_truthy
    end
  end

  context 'failed' do
    before do
      delete "/api/sessions?access_token=123"
    end

    it 'returns unauthorized status' do
      expect(response.status).to eq 401
    end

    it 'returns expired message' do
      expect(response_json["error"]).to eq "Your session has expired"
    end
  end
end
