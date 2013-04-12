# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  time = Time.now - (rand(4)+1).hours + ([0,30][rand(1)]).minutes 
  factory :event do
    title Faker::Company.name
    start time 
    stop time + 30.minutes
  end
end