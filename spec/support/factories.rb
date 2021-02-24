FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { "user@example.com" }
    password { "password" }
  end
end
