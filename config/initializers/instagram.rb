Instagram.configure do |config|
  config.client_id = Figaro.env.instagram_client_id!
  config.client_secret = Figaro.env.instagram_client_secret!
end
