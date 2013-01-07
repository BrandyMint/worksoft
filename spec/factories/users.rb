FactoryGirl.define do
  sequence :email do |n|
    "email#{n}@factory.com"
  end

  factory :user do
    email
    password 'please'
    # password_confirmation 'please'
    # avatar  { Rack::Test::UploadedFile.new('spec/fixtures/goaway.jpeg', 'image/jpg') }
  end
end
