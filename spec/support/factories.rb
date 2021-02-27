FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { "user@example.com" }
    uid { Faker::Number.within(range: 100000..999999).to_s }
    token { Faker::Number.within(range: 100000..999999) }
  end
  factory :omniauth_mock_user, parent: :user do
    email { 'john@example.com' }
    uid {'100000000000000000000'}
    token {'MOCK_OMNIAUTH_GOOGLE_TOKEN'}
  end
end
