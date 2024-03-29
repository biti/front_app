app_name = 'front_app_dev'

working_directory "/home/www/kuaipinhui/#{app_name}/current"

app_dir = "/home/www/kuaipinhui/#{app_name}"
shared_dir = "#{app_dir}/shared"
logs_dir = "#{shared_dir}/log"
tmp_dir = "#{shared_dir}/tmp"
pids_dir = "#{shared_dir}/pids"

user 'www', 'www'
worker_processes 1

listen "#{tmp_dir}/unicorn.socket", :backlog => 64
listen 3333, :tcp_nopush => true

preload_app true
timeout 30

pid "#{pids_dir}/unicorn.pid"

stderr_path "#{logs_dir}/unicorn.err.log"
stdout_path "#{logs_dir}/unicorn.out.log"

# 如果用USR2信号重启服务，必须要配置这一步
# 用来推出老的master
# 不明白请参考:
#   http://unicorn.bogomips.org/SIGNALS.html
#   https://github.com/blog/517-unicorn
#   https://gist.github.com/393178
before_fork do |server, worker|
  old_pid = "#{pids_dir}/unicorn.pid.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      puts "Send 'QUIT' signal to unicorn error!"
    end
  end
end

