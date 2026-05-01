threads_count = ENV.fetch("RAILS_MAX_THREADS", 3)
threads threads_count, threads_count

workers 0
bind "tcp://0.0.0.0:#{ENV.fetch("PORT", 3000)}"

environment ENV.fetch("RAILS_ENV") { "development" }

plugin :tmp_restart
plugin :solid_queue if ENV["SOLID_QUEUE_IN_PUMA"]

pidfile ENV["PIDFILE"] if ENV["PIDFILE"]