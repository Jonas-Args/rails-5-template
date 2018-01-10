require 'rails_helper'

describe 'POST /api/users', type: :request do

  let(:new_attributes) { {email: 'foo@gmail.com', first_name: 'foo', last_name: 'foo'} }
  let(:invalid_attributes) { {email: 'test@test.com'} }

  def post_request(attributes)
    post '/api/users',params: attributes
  end

  context 'successful registration' do

    it 'creates a new user' do
      expect {
        post_request(user: new_attributes)
      }.to change { User.count }.by 1
    end

    it 'returns the user id' do
      post_request(user: new_attributes)
      expect(response_json['id']).not_to be nil
    end

  end

  context 'unsuccessful registration' do
    describe 'validates email' do

      it 'can\'t be blank' do
        post_request(user: {email: nil})
        expect(response_json['errors']).to include "Email can't be blank"
      end

      it 'can\'t be the same' do
        post_request(user: new_attributes)
        post_request(user: new_attributes)
        expect(response_json['errors']).to include "Email has already been taken"
      end

    end

  end



end
