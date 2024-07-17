FactoryBot.define do
  factory :article do
    title { 'Testarticle' }
    description { 'This is a test article' }
    user
  end

  trait :article1 do
    title { 'Testarticle1' }
    description { 'This is a test article2' }
  end

  trait :article2 do
    title { 'Testarticle2' }
    description { 'This is a test article2' }
  end

  trait :long_title do
    title do
      'This is a very long title for an article it is actually way too long, or it should be, This is a very long title for an article it is actually way too long, or it should be, This is a very long title for an article it is actually way too long, or it should be'
    end
  end
end
