class User < ApplicationRecord
  extend Enumerize
  include ImageUploader::Attachment(:image) # adds an `image` virtual attribute
  def self.ransackable_attributes(_auth_object = nil)
    %w[
      id username email created_at updated_at
      encrypted_password reset_password_token
      reset_password_sent_at remember_created_at
      role profile_data image_data
    ]
  end

  def self.ransackable_associations(_auth_object = nil)
    ['articles']
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  before_save { self.email = email.downcase }
  has_many :articles
  validates :username, uniqueness: { case_sensitive: false },
                       presence: true, length: { minimum: 3, maximum: 25 }

  validates :email, presence: true, length: { maximum: 105 },
                    uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP, message: 'invalid email format' }
  enumerize :role, in: { restricted: 0, user: 1, admin: 2 }, default: :user, predicates: true
end
