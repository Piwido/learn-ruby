class Category < ApplicationRecord
    validates :name, uniqueness: {case_sensitive: false},  presence:true, length: { minimum: 3, maximum: 15}
    has_many :article_categories
    has_many :articles, through: :article_categories


end