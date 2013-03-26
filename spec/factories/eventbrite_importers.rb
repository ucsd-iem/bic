# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :eventbrite_importer do
    cache_event_data "MyString"
    import_attendees "MyString"
    import_tickets "MyString"
  end
end
