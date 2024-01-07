FactoryBot.define do
  factory :post do
    user { build :user }
    title { Faker::Food.ethnic_category }
    body { Faker::Lorem.paragraph }
  end
end
