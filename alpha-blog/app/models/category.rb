class Category < ApplicationRecord
  validates :name, uniqueness: { case_sensitive: false }, presence: true, length: { minimum: 3, maximum: 15 }
  has_many :article_categories
  has_many :articles, through: :article_categories
  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id id_value name updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[article_categories articles]
  end
end
