# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :dev_name do |n|
    "dev_x#{n}"
  end

  factory :developer_profile do
    name {generate(:dev_name)}
    user
  end
end
