# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product do
    name ""
    sku ""
    description ""
    price ""
    cost_price ""
    available_on ""
    permalink ""
    meta_description ""
    meta_keywords ""
    shipping_category ""
  end
end
