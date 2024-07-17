require 'rails_helper'

RSpec.describe '/articles', type: :request do
  describe 'GET /' do
    subject(:index) { get articles_path }
    context 'with user connected' do
      let(:user) { create(:user) }
      before { sign_in user }
      it 'GET /articles - User connected' do
        index

        expect(response).to have_http_status(200)
      end
    end

    context 'with user not connected' do
      it 'success' do
        # Validation nom it TIM
        index

        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'GET /new' do
    subject(:new_article) { get new_article_path }
    context 'with user connected' do
      let(:user) { create(:user) }
      before { sign_in user }
      it 'success' do
        new_article

        expect(response).to have_http_status(200)
      end
    end

    context 'with user not connected' do
      it 'redirects' do
        new_article

        expect(response).to have_http_status(302)
      end
    end
  end

  describe 'POST /' do
    context 'with user connected' do
      let(:user) { create(:user) }
      let(:article_attributes) { attributes_for(:article) }
      # Validation tim plcer la ligne let(:article_attributes) { create(:article, user: user) }
      before { sign_in user }
      it 'redirects' do
        post articles_path, params: { article: article_attributes }

        expect(response).to have_http_status(302)
      end

      it 'shows success message' do
        post articles_path, params: { article: article_attributes }

        follow_redirect!

        expect(response.body).to include('alert-success')
      end

      it 'article reaches database' do
        post articles_path, params: { article: article_attributes }

        follow_redirect!

        expect(Article.last.title).to eq(article_attributes[:title])
      end
    end
  end

  context 'with user connected - invalid article' do
    let(:article_attributes) { attributes_for(:article, title: '') }
    let(:user) { create(:user) }
    before { sign_in user }
    it 'returns 422' do
      post articles_path, params: { article: article_attributes }

      expect(response).to have_http_status(422)
    end
  end

  context 'with user not connected' do
    let(:article_attributes) { attributes_for(:article) }

    it 'redirects' do
      post articles_path, params: { article: article_attributes }

      expect(response).to have_http_status(302)
    end

    it 'shows error message' do
      post articles_path, params: { article: article_attributes }

      follow_redirect!

      expect(response.body).to include('You need to sign in or sign up before continuing')
    end
  end

  describe 'GET /:id' do
    subject(:show) { get article_path(article) }
    context 'with owner connected' do
      let(:owner) { create(:user) }
      let(:article) { create(:article, user: owner) }
      before { sign_in owner }
      it 'success' do
        show

        expect(response).to have_http_status(200)
      end
    end

    context 'with user connected - not owner' do
      let(:user) { create(:user) }
      let(:article) { create(:article) }
      before { sign_in user }
      it 'success' do
        show

        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'DELETE /:id' do
    subject(:delete_article) { delete article_path(article) }
    # TODO : tester avec juste delete
    context 'with owner connected' do
      let(:owner) { create(:user) }
      let(:article) { create(:article, user: owner) }
      before { sign_in owner }
      it 'redirects to index' do
        delete_article

        expect(response).to redirect_to(articles_path)
      end

      it 'shows success message' do
        delete_article
        follow_redirect!

        expect(response.body).to include('alert-success')
      end
    end

    context 'with user connected - not owner' do
      let(:user) { create(:user) }
      let(:article) { create(:article) }
      before { sign_in user }

      it 'redirects' do
        delete_article

        expect(response).to have_http_status(302)
      end

      it 'shows errors message' do
        delete_article
        follow_redirect!

        expect(response.body).to include('You can only delete your own articles')
      end
    end

    context 'with user not connected' do
      let(:article) { create(:article) }
      it 'redirects' do
        delete_article

        expect(response).to have_http_status(302)
      end

      it 'shows error message' do
        delete_article
        follow_redirect!

        expect(response.body).to include('You can only delete your own articles')
      end
    end
  end

  describe 'GET /:id/edit' do
    subject(:edit) { get edit_article_path(article) }

    context 'with owner connected' do
      let(:owner) { create(:user) }
      let(:article) { create(:article, user: owner) }
      before { sign_in owner }

      it 'success' do
        edit

        expect(response).to have_http_status(200)
      end
    end

    context 'with user not connected' do
      let(:article) { create(:article) }
      it 'redirects' do
        edit

        expect(response).to have_http_status(302)
      end

      it 'shows error message' do
        subject
        follow_redirect!

        expect(response.body).to include('You need to sign in or sign up before continuing.')
      end
    end

    context 'with user connected - not owner' do
      let(:user) { create(:user) }
      let(:article) { create(:article) }
      before { sign_in user }
      it 'redirects' do
        edit

        expect(response).to have_http_status(302)
      end

      it 'shows error message' do
        subject
        follow_redirect!

        expect(response.body).to include('You are not authorized to perform this action.')
      end
    end
  end

  describe 'PUT /:id (update)' do
    subject(:update_article) { put article_path(article), params: { article: new_attributes } }

    context 'with owner connected' do
      let(:owner) { create(:user) }
      let(:article) { create(:article, user: owner) }
      let(:new_attributes) { attributes_for(:article, :article2) }
      before { sign_in owner }
      it 'redirects' do
        update_article

        expect(response).to redirect_to(article_path(article))
      end

      it 'shows success message' do
        update_article
        follow_redirect!

        expect(response.body).to include('alert-success')
      end
    end

    context 'with user connected - not owner' do
      let(:user) { create(:user) }
      let(:article) { create(:article) }
      let(:new_attributes) { attributes_for(:article, title: 'test test test') }

      before { sign_in user }
      it 'redirects' do
        update_article

        expect(response).to have_http_status(302)
      end

      it 'shows error message' do
        update_article
        follow_redirect!

        expect(response.body).to include('You are not authorized to perform this action')
      end
    end

    context 'with admin - not owner connected' do
      let(:admin) { create(:user, role: 'admin') }
      let(:article) { create(:article) }
      let(:new_attributes) { attributes_for(:article, title: 'test test test') }
      before { sign_in admin }
      it 'redirects to article' do
        update_article

        expect(response).to redirect_to(article_path(article))
      end

      it 'shows success message' do
        update_article
        follow_redirect!

        expect(response.body).to include('alert-success')
      end
    end

    context 'with user not connected' do
      let(:article) { create(:article) }
      let(:new_attributes) { attributes_for(:article, title: 'test test test') }
      it 'redirects' do
        update_article

        expect(response).to have_http_status(302)
      end

      it 'shows errors message' do
        update_article
        follow_redirect!

        expect(response.body).to include('You need to sign in or sign up before continuing')
      end
    end
  end
end
