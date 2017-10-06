rails_root = "/home/deploy/apps/pushbox/current/inmyroom"
shared_path = "/home/deploy/apps/pushbox/inmyroom/shared"
pid_file   = "#{shared_path}/tmp/pids/unicorn.pid"
socket_file= "#{shared_path}/tmp/sockets/unicorn.sock"
listen_address = "127.0.0.1:3001"
log_file   = "#{shared_path}/inmyroom/log/unicorn.log"
err_log    = "#{shared_path}/inmyroom/log/unicorn.err"
old_pid    = pid_file + '.oldbin'

pid pid_file
preload_app true
stderr_path err_log
stdout_path log_file

timeout 60
listen listen_address, :backlog => 1024

working_directory rails_root
worker_processes 40

GC.copy_on_write_friendly = true if GC.respond_to?(:copy_on_write_friendly=)

before_exec do |server|
  Dotenv.overload("#{rails_root}/.env", "#{rails_root}/.env.production")
  ENV["BUNDLE_GEMFILE"] = "#{ rails_root }/Gemfile"
end

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
  ActiveRecord::Base.connection.disconnect!

  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and
  ActiveRecord::Base.establish_connection
end
