class User < ApplicationRecord
    has_many :articles
    validates :username, uniqueness: {case_sensitive: false},   
                        presence: true, length: { minimum: 3, maximum: 25}
    VALID_EMAIL_REGEX =  /\A[a-zA-Z]+@[a-zA-Z]+\.[a-zA-Z]+\z/i #i for case insensitive

    validates :email, presence: true, length: { maximum: 105 }, 
                        uniqueness: {case_sensitive: false}, format: {with: VALID_EMAIL_REGEX, message: "invalid email format"}
end
