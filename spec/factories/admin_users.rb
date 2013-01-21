# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin_user, class: User do
    email
    password '123456'
    after(:create) do |user, evaluator|
      user.roles << FactoryGirl.create(:role, name: 'admin')
    end
  end
end
