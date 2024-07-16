require 'rails_helper'

RSpec.describe 'CreateArticles', type: :request do
  describe 'GET /create_articles' do
    it 'can access article creation page if connected' do
      sign_in create(:user)

      get new_article_path

      expect(response).to have_http_status(200)
    end

    it 'redirected from article creation page if not connected' do
      get new_article_path

      expect(response).to have_http_status(302)
    end
  end
end
