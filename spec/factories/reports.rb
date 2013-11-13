# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :report, :class => 'Reports' do
    location "MyString"
    time ""
    action_type 1
    description "MyText"
  end
end
