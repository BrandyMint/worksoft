# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_system do
    user_id 1
    name "MyString"
    kernel_version 1
    configuration_id 1
    configuration_version 1
  end
end
