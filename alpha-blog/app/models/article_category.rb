class ArticleCategory < ApplicationRecord
  belongs_to :article
  belongs_to :category
  def self.ransackable_attributes(_auth_object = nil)
    %w[article_id category_id created_at id updated_at]
  end
  def self.ransackable_associations(auth_object = nil)
    ["article", "category"]
  end

end
