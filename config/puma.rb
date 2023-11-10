


app_root = ENV['APP_ROOT'] || '.'
rails_env = ENV['RAILS_ENV'] || 'production'
ip_addr = ENV['IP_ADDR'] || 'localhost'
port = ENV['PORT'] || 3000
ssl_key = ENV['SSL_KEY']
ssl_cert = ENV['SSL_CERT']


# Set Puma parameters
preload_app!
rackup DefaultRackup
environment rails_env
pidfile "#{app_root}/tmp/pids/puma.pid"
state_path "#{app_root}/tmp/pids/puma.state"
threads 0, 16
workers 2
stdout_redirect "#{app_root}/log/puma.log", "#{app_root}/log/puma.err", true if rails_env.downcase == 'production'

# HTTP or HTTPS
if ssl_key.present? && ssl_cert.present?
  bind "ssl://#{ip_addr}:#{port}?key=#{ssl_key}&cert=#{ssl_cert}"
else
  bind "tcp://#{ip_addr}:#{port}"
end

