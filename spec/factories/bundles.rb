# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :version_str do |n|
    "1.#{n}"
  end

  factory :bundle do
    supported_kernel_versions "7,8"
    changelog 'new cool features'
    version_str
    source_file {Rack::Test::UploadedFile.new('spec/fixtures/upic.gif', 'image/gif')}
    association :app, factory: :app
  end
end
