require 'rails_helper'

RSpec.describe 'UserLogins', type: :request do
  before(:example) do
    create(:user)
  end

  describe 'Access to login page' do
    it 'can access if unlogged' do
      get new_user_registration_path

      expect(response).to have_http_status(200)
    end

    it 'redirected if logged' do
      sign_in create(:user, :user2)

      get new_user_registration_path

      expect(response).to have_http_status(302)
    end
  end

  describe 'Do login' do
    it 'can login' do
      pending('Demander à Tim')
      sign_in create(:user, :user2)

      expect(response).to have_http_status(200)
    end

    it 'cannot login with wrong password' do
      user_params = attributes_for(:user, :wrong_password)

      post user_session_path, params: { user: user_params }

      expect(response.status.to_s).to start_with('4')
    end
  end
end
