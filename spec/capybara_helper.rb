#encoding: utf-8
require 'capybara/poltergeist'
require 'capybara-screenshot/rspec'


RSpec.configure do |config|

  Capybara.server_port = Settings.try(:capybara).port.to_i or
      raise( "Установи Settings.capybara.port согласно http://wiki.brandymint.ru/wiki/%D0%A2%D0%B5%D1%81%D1%82%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5" )

  Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(app, {
      :phantomjs_options => ["--debug=#{ENV['DEBUG'].present? ? 'yes' : 'no'}",
                             '--load-images=no',
                             '--ignore-ssl-errors=yes',
                             '--local-to-remote-url-access=no' ],
      :inspector => false,
      :debug => ENV['DEBUG']
    })
  end

  Capybara.javascript_driver = :poltergeist
  Capybara.default_host = '127.0.0.1'
  Capybara.server_boot_timeout = 10
  Capybara.default_wait_time = 5

end
