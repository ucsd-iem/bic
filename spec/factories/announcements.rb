# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :announcement do
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.sentences(rand(5)+4).join(' ') }
  end
end
