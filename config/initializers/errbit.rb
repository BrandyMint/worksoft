if defined? Airbrake
   Airbrake.configure do |config|
      config.api_key		 	= '3c43b9374288c35ce533fb7003761d61'
      config.host			= 'errbit.brandymint.ru'
      config.port			= 80
      config.secure			= config.port == 443
   end
end
