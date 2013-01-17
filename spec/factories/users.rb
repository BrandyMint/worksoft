FactoryGirl.define do
  sequence :email do |n|
    "email#{n}@factory.com"
  end

  factory :user do
    email
    password '123456'
    password_confirmation '123456'
    # avatar  { Rack::Test::UploadedFile.new('spec/fixtures/goaway.jpeg', 'image/jpg') }
  
    after(:create) do |user, evaluator|
      user.send :setup_activation
      user.save!
    end
  end

  factory :developer, class: User do
    email
    password '123456'
    association :developer_profile, factory: :developer_profile
    after(:create) do |user, evaluator|
      user.send :setup_activation
      user.save!
      user.activate!
    end
  end
end
