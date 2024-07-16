class Article < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    %w[created_at description id title updated_at user_id views]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[user categories article_categories]
  end
  belongs_to :user
  has_many :article_categories
  has_many :categories, through: :article_categories
  validates :title, presence: true, length: { minimum: 6, maximum: 100 }
  validates :description, presence: true, length: { minimum: 7, maximum: 10_000 }
end
