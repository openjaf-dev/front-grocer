# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :line_item do
    name "MyString"
    quantity 1
    price 1.5
    order nil
  end
end
