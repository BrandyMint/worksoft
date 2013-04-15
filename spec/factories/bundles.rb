# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :version do |n|
    "1.#{n}"
  end

  factory :bundle do
    supported_kernel_versions "7,8"
    changelog 'new cool features'
    version
    source_file {Rack::Test::UploadedFile.new('spec/fixtures/proceed.epf', 'file/epf')}
    association :app, factory: :app
    supported_configurations {|sc| [sc.association(:supported_configuration)]}
  end
end
