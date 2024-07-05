class Article < ApplicationRecord
    belongs_to :user
    validates :title, presence: true, length: { minimum: 6, maximum: 100 }
    validates :description, presence: true, length: { minimum: 7, maximum: 10000 }
  end
  