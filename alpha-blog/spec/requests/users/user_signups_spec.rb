require 'rails_helper'

RSpec.describe "UserSignups", type: :request do

  describe "GET /user_signups" do
    it "can get the page" do
      get new_user_registration_path
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /user_signups valid signup" do 
    it "can create an user" do 
      pending("Need to implement ajax")
      post user_registration_path, params: { user: create(:user) }
      expect(response).to have_http_status(200)
    end 
  end 

  describe "POST /user_signups invalid signups" do 
    it "cannot create an user with no mail" do
      user_params = attributes_for(:user, :no_mail)
      post user_registration_path, params: { user: user_params }
      expect(response).to have_http_status(422)
    end 

    it "cannot create an user with no username" do 
      user_params = attributes_for(:user, :no_username)
      post user_registration_path, params: { user: user_params }
      expect(response).to have_http_status(422)
    end

    it "cannot create an user with short password" do
      user_params = attributes_for(:user, :short_password)
      post user_registration_path, params: { user: user_params }
      expect(response).to have_http_status(422)
    end 

    it "cannot create an user with no role" do 
      pending("Add role validation")
      user_params = attributes_for(:user, :no_role)
      post user_registration_path, params: { user: user_params }
      expect(response).to have_http_status(422)
    end 
  end

  describe "Created user appears in the users index" do 
    it "appears in the users index" do
      user_params = attributes_for(:user, username: "azerty")
      post user_registration_path, params: { user: user_params }
      get users_path
      expect(response.body).to include("azerty")
    end
  end 
end
