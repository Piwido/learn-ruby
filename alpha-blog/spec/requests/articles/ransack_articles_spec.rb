require 'rails_helper'

RSpec.describe 'ArticlesRansack', type: :feature do
  describe 'Sorting articles by title' do
    before do
      titles = %w[ArticleE ArticleD ArticleC ArticleB ArticleA]
      titles.shuffle.each do |title|
        create(:article, title:)
      end
      visit articles_path
    end

    it 'successfully sorts articles by title ascending' do
      click_link 'Title'

      article_titles = all('.article-title').map(&:text)
      expected_titles = article_titles.sort
      expect(article_titles).to eq(expected_titles)
    end
  end
end
