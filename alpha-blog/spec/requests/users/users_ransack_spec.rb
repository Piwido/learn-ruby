require 'rails_helper'

RSpec.describe 'UsersRansack', type: :feature do
  describe 'Sorting users by users' do
    before do
      usernames = %w[ArticleE ArticleD ArticleC ArticleB ArticleA]
      usernames.shuffle.each do |name|
        create(:user, username: name)
      end
      visit users_path
    end

    it 'successfully sorts users by username ascending' do
      click_link 'Username'

      user_names = all('.user-username').map(&:text)
      expected_names = user_names.sort
      expect(user_names).to eq(expected_names)
    end
  end
end
