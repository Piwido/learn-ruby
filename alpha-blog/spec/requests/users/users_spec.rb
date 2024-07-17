require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /users' do
    it 'GET /users - several users in database' do
      create(:user, username: 'test1', email: 'test134567890@test.test')
      create(:user, username: 'test2', email: 'test234567JKUYFBN@test.test')
      create(:user, username: 'test3', email: '123456789OKJNBVDtest@test.test')

      get users_path

      expect(response.body).to include('test1')
      expect(response.body).to include('test2')
      expect(response.body).to include('test3')
    end
  end

  describe 'GET /users/:id' do
    let(:user1) { create(:user, username: 'test1', email: 'test134567890@test.test') }
    let(:user2) { create(:user, username: 'test2', email: 'test234567JKUYFBN@test.test') }

    it 'GET /users/:id - User connected' do
      sign_in user1
      get user_path(user1)
      expect(response).to have_http_status(200)
      expect(response.body).to include('test1')
      expect(response.body).to include('Upload picture')
    end

    it 'GET /users/:id - User not connected' do
      # user2 = create(:user, username: 'test2', email: 'test234567JKUYFBN@test.test')

      get user_path(user2)
      expect(response.status.to_s).to start_with('3')
      follow_redirect!
      expect(response.body).to include('You need to sign in or sign up before continuing')
    end

    it 'GET /users/:id - User connected to another user' do
      sign_in user2
      get user_path(user1)
      expect(response).to have_http_status(200)
      expect(response.body).to include('test1')
      expect(response.body).not_to include('Upload picture')
    end
  end
end
