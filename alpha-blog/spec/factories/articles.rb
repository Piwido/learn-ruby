FactoryBot.define do
  factory :article do
    title { 'Testarticle' }
    description { 'This is a test article' }
    user_id { 1 }
  end
end
