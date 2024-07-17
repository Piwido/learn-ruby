require 'rails_helper'

RSpec.describe '/categories', type: :request do
  describe 'GET /index' do
    subject(:get_categories) { get categories_path }

    context 'with user not connected - several categories present' do
      it 'displays each categories' do
        (1..5).each do |i|
          create(:category, name: "Testcategory#{i}")
        end
        # Validation Tim

        get_categories

        (1..5).each do |i|
          expect(response.body).to include("Testcategory#{i}")
        end
      end
    end

    context 'with user connected - several categories present' do
      let(:user) { create(:user) }
      before { sign_in user }
      it 'displays each categories' do
        (1..5).each do |i|
          create(:category, name: "Testcategory#{i}")
        end
        # Validation Tim

        get_categories

        (1..5).each do |i|
          expect(response.body).to include("Testcategory#{i}")
        end
      end
    end
  end

  describe 'GET /new' do
    subject(:get_new_category) { get new_category_path }

    context 'with admin connected' do
      let(:admin) { create(:user, :admin) }
      before { sign_in admin }
      it 'success' do
        get_new_category

        expect(response).to have_http_status(200)
      end
    end

    context 'when user is connected, not admin' do
      let(:user) { create(:user) }
      before { sign_in user }
      it 'redirects to categories index' do
        get_new_category

        expect(response).to redirect_to(categories_path)
      end

      it 'shows error message' do
        get_new_category
        follow_redirect!

        expect(response.body).to include('alert-danger')
      end
    end

    context 'when no user is connected' do
      it 'redirects to categories index' do
        get_new_category

        expect(response).to redirect_to(categories_path)
      end
    end
  end

  describe 'POST /create' do
    subject(:create_category) { post categories_path, params: { category: category_params } }

    context 'with admin connected and valid parameters' do
      let(:category_params) { attributes_for(:category) }
      let(:admin) { create(:user, :admin) }
      before { sign_in admin }
      it 'redirects to new category' do
        create_category

        expect(response).to redirect_to(Category.last)
      end
      it 'shows success message' do
        create_category
        follow_redirect!

        expect(response.body).to include('alert-success')
      end

      it 'hits database' do
        expect { create_category }.to change(Category, :count).by(1)
        expect(Category.last.name).to eq(category_params[:name])
      end
    end

    context 'with admin connected and invalid parameters' do
      let(:category_params) { attributes_for(:category, name: nil) }
      let(:admin) { create(:user, :admin) }
      before { sign_in admin }

      it 'responds with error 422' do
        create_category

        expect(response).to have_http_status(422)
      end

      it 'does not hits database' do
        expect { create_category }.not_to change(Category, :count)
      end
    end

    context 'with user connected, not admin' do
      let(:category_params) { attributes_for(:category) }
      let(:user) { create(:user) }
      before { sign_in user }
      it 'does not allow category creation' do
        create_category

        expect(response).to redirect_to(categories_path)
      end
    end

    context 'with no user connected' do
      let(:category_params) { attributes_for(:category) }
      it 'redirects to categories index' do
        create_category

        expect(response).to redirect_to categories_path
      end
      it 'shows error message' do
        create_category
        follow_redirect!

        expect(response.body).to include('alert-danger')
      end
    end
  end

  describe 'GET /:id/edit' do
    subject(:edit_category) { get edit_category_path(category) }

    context 'with admin connected' do
      let(:category) { create(:category) }
      let(:admin) { create(:user, :admin) }
      before { sign_in admin }
      it 'allows editing' do
        edit_category

        expect(response).to have_http_status(200)
      end
    end

    context 'with user connected, not admin' do
      let(:user) { create(:user) }
      before { sign_in user }
      let(:category) { create(:category) }
      it 'redirects to categories index' do
        edit_category

        expect(response).to redirect_to(categories_path)
      end

      it 'shows error message' do
        edit_category
        follow_redirect!

        expect(response.body).to include('alert-danger')
      end
    end

    context 'when no user is connected' do
      let(:category) { create(:category) }
      it 'redirects to categories index' do
        edit_category

        expect(response).to redirect_to(categories_path)
      end

      it 'shows error message' do
        edit_category
        follow_redirect!

        expect(response.body).to include('alert-danger')
      end
    end
  end

  describe 'PUT /:id' do
    subject(:update_category) { put category_path(category), params: { category: { name: 'Updated Name' } } }
    context 'with admin connected' do
      let(:category) { create(:category) }
      let(:admin) { create(:user, :admin) }
      before { sign_in admin }

      it 'updates the category' do
        update_category

        expect(category.reload.name).to eq('Updated Name')
      end

      it 'redirects to new category' do
        update_category

        expect(response).to redirect_to(category)
      end

      it 'shows success message' do
        update_category
        follow_redirect!

        expect(response.body).to include('alert-success')
      end
    end

    context 'with user connected, not admin' do
      let(:category) { create(:category) }
      let(:user) { create(:user) }
      before { sign_in user }

      it 'redirects to categories index' do
        update_category

        expect(response).to redirect_to(categories_path)
      end

      it 'shows error message' do
        update_category
        follow_redirect!

        expect(response.body).to include('alert-danger')
      end
    end

    context 'when no user is connected' do
      let(:category) { create(:category) }

      it 'redirects to categories index' do
        update_category

        expect(response).to redirect_to(categories_path)
      end

      it 'shows error message' do
        update_category
        follow_redirect!

        expect(response.body).to include('alert-danger')
      end
    end
  end

  describe 'GET /:id' do
    subject(:get_category) { get category_path(category) }

    context 'with user not connected' do
      let(:category) { create(:category) }
      it 'success' do
        get_category

        expect(response).to have_http_status(200)
      end

      it 'shows category details' do
        get_category

        expect(response.body).to include(category.name)
      end
    end

    context 'with user connected' do
      let(:category) { create(:category) }
      let(:user) { create(:user) }
      before { sign_in user }
      it 'success' do
        get_category

        expect(response).to have_http_status(200)
      end

      it 'shows category details' do
        get_category

        expect(response.body).to include(category.name)
      end
    end

    context 'with admin connected' do
      let(:category) { create(:category) }
      let(:admin) { create(:user, :admin) }
      before { sign_in admin }
      it 'success' do
        get_category

        expect(response).to have_http_status(200)
      end

      it 'shows category details' do
        get_category

        expect(response.body).to include(category.name)
      end
    end
  end
end
