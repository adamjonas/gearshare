Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :developer unless Rails.env.production?
  provider :facebook, '278972522218459', '2d4afb460371b74e7e4f05b80d6e8211'
end