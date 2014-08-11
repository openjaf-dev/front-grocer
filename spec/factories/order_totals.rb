# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order_total do
    adjustment 1.5
    tax 1.5
    shipping 1.5
    payment 1.5
    order 1.5
    item 1.5
    order nil
  end
end
