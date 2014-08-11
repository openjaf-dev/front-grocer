# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :payment do
    number 1
    status "MyString"
    amount 1.5
    payment_method "MyString"
    order nil
  end
end
