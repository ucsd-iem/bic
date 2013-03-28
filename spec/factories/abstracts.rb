# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :abstract do
    title { Faker::Lorem.sentence((10..20).to_a[rand 10]) }
    authors { authors = [];(rand(8)+1).times { authors << Faker::Name.name }; "#{authors.join ', '}." }
    affiliations { affiliations = []; (rand(5)+1).times { affiliations << "#{Faker::Address.name}, #{Faker::Address.street_suffix}, #{Faker::Address.city}, #{Faker::Address.state} #{Faker::Address.zip_code}" }; "#{affiliations.join '. '}." }
    body { Faker::Lorem.sentences(rand(5)+4) }
    personal_statement { Faker::Lorem.sentences(rand(5)+4) }
  end
end