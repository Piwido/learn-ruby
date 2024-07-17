require 'rails_helper'

RSpec.describe 'CategoriesRansack', type: :feature do
  describe 'Sorting categories by title' do
    before do
      names = %w[ArticleE ArticleD ArticleC ArticleB ArticleA]
      names.shuffle.each do |title|
        create(:category, name: title)
      end
      visit categories_path
    end

    it 'successfully sorts categories by title ascending' do
      click_link 'Name'

      categories_names = all('.category-name').map(&:text)
      expected_names = categories_names.sort
      expect(categories_names).to eq(expected_names)
    end
  end
end
