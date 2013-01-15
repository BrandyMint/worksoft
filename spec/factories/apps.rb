# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :name do |n|
    "1c_ver#{n}"
  end
  
  factory :app do
    name
    developer_profile
    association :kind, factory: :kind
  end
end
