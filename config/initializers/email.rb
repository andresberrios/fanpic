
# Default URL options

host = Figaro.env.app_host!
port = Figaro.env.app_port!
protocol = Figaro.env.app_protocol!
url_options = {host: host, protocol: protocol}
unless (protocol == 'http' && port == '80') || (protocol == 'https' && port == '443')
  url_options[:port] = port
end
Rails.application.config.action_mailer.default_url_options = url_options


# SMTP configuration

begin
  uri = URI.parse Figaro.env.smtp_url!
rescue URI::InvalidURIError
  raise 'Invalid smtp_url environment variable!'
end

Rails.application.config.action_mailer.delivery_method = :smtp
Rails.application.config.action_mailer.smtp_settings = {
    address: uri.host,
    port: uri.port,
    domain: (uri.path || '').split('/').second,
    user_name: URI.decode(uri.user),
    password: uri.password,
    authentication: uri.scheme,
    enable_starttls_auto: true
}
