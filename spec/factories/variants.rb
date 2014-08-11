# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :variant do
    sku "MyString"
    price 1.5
    cost_price 1.5
    quantity 1
    product nil
  end
end
