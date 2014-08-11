# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :address do
    firstname "MyString"
    lastname "MyString"
    address1 "MyString"
    address2 "MyString"
    city "MyString"
    state "MyString"
    country "MyString"
    phone "MyString"
    zipcode "MyString"
  end
end
