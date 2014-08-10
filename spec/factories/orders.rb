# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order do
    number "MyString"
    status "MyString"
    channel "MyString"
    email "MyString"
    currency "MyString"
    placed_on ""
  end
end
