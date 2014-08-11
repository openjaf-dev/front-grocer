# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :shipment do
    email "MyString"
    cost 1.5
    status "MyString"
    stock_location "MyString"
    shipping_method "MyString"
    tracking "MyString"
    updated_at "2014-08-10"
    shipped_at "2014-08-10"
    variant nil
    product nil
    order nil
  end
end
