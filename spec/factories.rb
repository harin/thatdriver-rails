require 'factory_girl'

FactoryGirl.define do
  factory :user do
    first_name 'Foo'
    last_name 'Bar'
    email { "#{last_name}@test.com"}
    username { "#{last_name}"}
    password '123456'
  end  
end