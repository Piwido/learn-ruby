class ArticlePolicy < ApplicationPolicy
  attr_reader :user, :article

  def initialize(user, article)
    @user = user
    @article = article
  end

  def destroy?
    user&.admin? || user == article.user
  end

  def create?
    user&.admin? || user&.user?
  end

  def update?
    user&.admin? || user == article.user
  end
end
