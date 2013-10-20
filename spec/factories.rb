require 'factory_girl'

FactoryGirl.define do
  factory :user do
    first_name 'Foo'
    last_name 'Bar'
    email { "#{last_name}@test.com"}
    username { "#{last_name}"}
    password '123456'
  end 

  factory :lost_item_api do
    time_lost '2013-10-17T23:03:54+07:00'
    item_name 'Foo'
    item_desc 'BarBarFoo'
    location 'FooTown'
    plate_no 'กก1'
    taxi_description 'none'
    contact 'none'
  end

  factory :found_item_api do
    time_lost '2013-10-17T23:03:54+07:00'
    item_name 'Foo'
    item_desc 'BarBarFoo'
    location 'FooTown'
    plate_no 'กก1'
    taxi_description 'none'
    contact 'none'
  end
end