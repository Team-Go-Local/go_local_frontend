FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { "user@example.com" }
    uid { Faker::Number.within(range: 100000..999999).to_s }
    token { Faker::Number.within(range: 100000..999999) }
    id { 1 }
  end

  factory :omniauth_mock_user, parent: :user do
    email { 'john@example.com' }
    uid {'100000000000000000000'}
    token {'MOCK_OMNIAUTH_GOOGLE_TOKEN'}
    id { 1 }
  end
# The excursion factory below is for a PORO
# To use you will need to use build
  factory :excursion do
    initialize_with { new(id: Faker::Number.within(range: 1..1000),
                          attributes:
                          { title: Faker::Name.first_name,
                            description: Faker::Coffee.notes,
                            location: Faker::Address.city,
                            place_id: Faker::String.random(length: 27)
                          })}
  end
end
