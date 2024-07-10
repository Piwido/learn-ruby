require 'rails_helper'

RSpec.describe "/categories", type: :request do

  describe "GET /new" do
    it "admin can get /new_category" do
      sign_in create(:user, :admin)

      get new_category_path

      expect(response).to have_http_status(200)
    end

    it "unlogged user cannot get /new_category" do 
      get new_category_path

      expect(response).to have_http_status(302)
    end 

    it "logged user not admin cannot get /new_category" do 
      sign_in create(:user)

      get new_category_path

      expect(response).to have_http_status(302)
    end 
  end

  describe "POST /new_category" do 
    let(:category_params) { attributes_for(:category) }

    before { sign_in user }

    context "with an admin" do
      let(:user) { create(:user, :admin) } 

      it "can create category if admin" do
        post categories_path, params: { category: category_params }

        expect(response).to have_http_status(302)
      end 

      it "cannot create invalid category" do 
        category_params = attributes_for(:category, :short_name)

        post categories_path, params: { category: category_params }

        expect(response).to have_http_status(422)
      end

      it "cannot create invalid category no name" do 
        category_params = attributes_for(:category, name: nil)

        post categories_path, params: { category: category_params }

        expect(response).to have_http_status(422)
      end

      it "created categories appear in the index" do
        post categories_path, params: { category: category_params }
        get categories_path

        expect(response.body).to include("Testcategory")
      end 
    end 

    context "with a user" do
      let(:user) { create(:user) }
        it "cannot create category if not admin" do
          pending("Cf Tim")
          post categories_path, params: { category: category_params }

          get categories_path

          expect(response).to have_http_status(302)
          expect(response.body).not_to include(category_params[:name])
      end 
    end
  end 
end
