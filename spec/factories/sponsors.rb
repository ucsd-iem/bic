# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sponsor do
    name Faker::Company.name
    url 'http://' + Faker::Internet.domain_name
    email Faker::Internet.email
    level 'Supporting'
    logo File.new(Rails.root + 'spec/fixtures/images/rails.png')
  end
end
