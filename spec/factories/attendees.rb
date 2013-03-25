# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :valid_attendee do
    first_name "Just"
    last_name "Valid"
    email "valid@user.com"
    created "2013-03-24 15:12:21"
    modified "2013-03-24 15:12:21"
    created_at "2013-03-24 15:12:21"
    updated_at "2013-03-24 15:12:21"
    authentication_token "TpvZdGjqsukmXCgSPkYd"
  end

  factory :invalid_attendee do
    first_name "Just"
    last_name "Invalid"
  end
end
