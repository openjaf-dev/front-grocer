# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :option do
    option_type "MyString"
    option_value "MyString"
    variant nil
  end
end
