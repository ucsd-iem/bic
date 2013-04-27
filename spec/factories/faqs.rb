# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :faq do
    question "What is #{Faker::Lorem.word}"
    answer Faker::Lorem.sentence
  end
end
