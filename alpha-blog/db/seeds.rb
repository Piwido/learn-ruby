# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
if Article.none?
  30.times do
    title = Faker::Lorem.paragraph_by_chars(number: rand(6..100)) # Adjust to generate titles between 6 and 100 characters
    description = Faker::Lorem.paragraph_by_chars(number: rand(20..200), supplemental: false) # Generate descriptions between 20 and 200 characters
    views = rand(1..100_000) # Generate a random number of views
    # Assuming there is at least one user in your database. Replace `User.first` with a more dynamic selector if needed.
    user = User.order('RANDOM()').first # Or `User.find_by(id: 1)` or `User.order("RANDOM()").first` for a random user

    Article.create(title:, description:, user:, views:)
  end
end
if Rails.env.development?
  AdminUser.create!(email: 'admin@example.com', password: 'password',
                    password_confirmation: 'password')
end
