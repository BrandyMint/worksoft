FactoryGirl.define do
  sequence :name do |n|
    "1c_ver#{n}"
  end
  
  factory :app do
    name
    developer_profile
    association :kind, factory: :kind
    #icon {Rack::Test::UploadedFile.new('spec/fixtures/upic.gif', 'image/gif')}
  end
end
