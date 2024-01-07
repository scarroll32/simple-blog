FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { "sample-password" }
    password_confirmation { "sample-password" }
  end
end
