# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :source do
    names ""
    month 1
    year 1
    cc_type "MyString"
    last_digits 1
    payment nil
  end
end
