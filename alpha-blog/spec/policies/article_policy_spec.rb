require 'rails_helper'

RSpec.describe ArticlePolicy do
  subject { described_class }

  let(:admin) { create(:user, :admin) }
  let(:user) { create(:user, email: '1234567@gmail.com', username: '1234545') }
  let(:article) { create(:article, user:) }
  let(:other_user) { create(:user, :user2, email: 'azerty@gmail.com') }

  permissions :destroy? do
    it 'allows admin to destroy any article' do
      expect(subject).to permit(admin, article)
    end

    it 'allows user to destroy their own article' do
      expect(subject).to permit(user, article)
    end

    it "denies user to destroy another user's article" do
      expect(subject).not_to permit(other_user, article)
    end
  end

  permissions :create? do
    it 'allows admin to create an article' do
      expect(subject).to permit(admin, Article.new)
    end

    it 'allows any user to create an article' do
      expect(subject).to permit(user, Article.new)
    end
  end

  permissions :update? do
    it 'allows admin to update any article' do
      expect(subject).to permit(admin, article)
    end

    it 'allows user to update their own article' do
      expect(subject).to permit(user, article)
    end

    it "denies user to update another user's article" do
      expect(subject).not_to permit(other_user, article)
    end
  end
end
