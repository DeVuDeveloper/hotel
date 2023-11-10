# frozen_string_literal: true

max_threads_count = ENV.fetch("RAILS_MAX_THREADS", 5)
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count

worker_timeout 3600 if ENV.fetch("RAILS_ENV", "development") == "development"

# port ENV.fetch("PORT", 3000)

bind "ssl://0.0.0.0:443?key=/root/key_nopass.pem&cert=/root/cert.pem"

environment ENV.fetch("RAILS_ENV", "development")

pidfile ENV.fetch("PIDFILE", "tmp/pids/server.pid")

workers ENV.fetch("WEB_CONCURRENCY") { 4 }

stdout_redirect "log/puma.log", "log/puma.log", true

plugin :tmp_restart

