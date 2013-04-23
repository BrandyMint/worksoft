# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :supported_configuration do
    bundle_id 1
    association :configuration
    versions '*'
  end
end
