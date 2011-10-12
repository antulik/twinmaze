$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) # Add RVM's lib directory to the load path.

require "bundler/capistrano"
#require "rvm/capistrano"                  # Load RVM's capistrano plugin.
#set :rvm_ruby_string, '1.9.2p180@rails3'        # Or whatever env you want it to run in.
#set :rvm_type, :user  # Copy the exact line. I really mean :user here


set :application, "twinmaze"
set :db_name, "twinmaze"
set :db_username, "twinmaze"
set :db_password, ""

set :use_sudo, false
set :repository, "repo@github.com"
set :scm, :git

set :user, "git"
set :deploy_to, "/var/rapp/twinmaze"
set :deploy_via, :remote_cache
default_run_options[:pty] = true
set :web_server, :nginx
set :nginx_server_name, 'address.com'

server "000.000.000.000", :app, :web, :db, :primary => true

after 'deploy:config', 'deploy:symlink_config'
after 'deploy:symlink', 'deploy:symlink_shared'
after 'deploy:symlink', 'deploy:config'
after 'deploy:symlink', 'deploy:permissions'
after 'deploy:symlink', 'monit:config'
after 'nginx:config', 'nginx:symlink_config'
after 'monit:config', 'monit:symlink_config'
after 'monit:symlink_config', 'monit:restart'


namespace :deploy do
  task :start do
    ;
  end
  task :stop do
    ;
  end
  task :restart, :roles => :app, :except => {:no_release => true} do
    run "#{try_sudo} touch #{File.join(current_path, 'tmp', 'restart.txt')}"
  end

  desc "Symlink shared configs and folders on each release."
  task :symlink_shared do
    run "ln -nfs #{shared_path}/tmp #{release_path}/tmp"
  end

  task :symlink_config do
    run "ln -nfs #{shared_path}/config/database.yml #{current_path}/config/database.yml"
  end

  task :permissions do
    run "chmod +x #{current_path}/script/delayed_job "
  end

  task :config do
    database_yml = <<-EOF
production:
  adapter: mysql
  host: localhost
  encoding: utf8
  database: #{db_name}
  username: #{db_username}
  password: #{db_password}
EOF
    put database_yml, "#{shared_path}/config/database.yml"
  end
end

namespace :nginx do
  task :config, :roles => :app do
    app_public_path = File.join(current_path, 'public')
    conf = <<-EOF
server {
      listen 80;
      server_name #{nginx_server_name};
      root #{app_public_path};
      passenger_enabled on;
  }
EOF
    run "mkdir -p #{shared_path}/config"
    put conf, File.join(shared_path, "config/nginx.conf")
  end

  task :symlink_config do
    nginx_conf_path = File.join("/opt/nginx/phd-sites/", nginx_server_name)
    run "#{sudo} ln -nfs #{shared_path}/config/nginx.conf #{nginx_conf_path}"
  end

  task :restart do
    run "#{sudo} /etc/init.d/nginx restart"
  end
end

# http://mmonit.com/monit/documentation/monit.html
namespace :monit do
  desc "Generates monit config file in shared/config folder"
  task :config, :roles => :app do
    pid = File.join(current_path, "tmp/pids/delayed_job.0.pid")

    cmd = "RAILS_ENV=production " + File.join(current_path, "script/delayed_job") + " --identifier=0"

    conf = <<-EOF
check process delayed_job_0 with pidfile #{pid}
  start program = "/bin/su - git -c '#{cmd} start' rails"
  stop program  = "/bin/su - git -c '#{cmd} stop' rails"

  if cpu > 80% for 3 cycles then alert
  if loadavg(5min) greater than 2 for 3 cycles then alert
EOF

    run "mkdir -p #{shared_path}/config"
    put conf, File.join(shared_path, "config/monit.conf")
  end

  task :symlink_config do
    monit_path = "/etc/monit.d"
    run "#{sudo} ln -nfs #{shared_path}/config/monit.conf #{monit_path}/#{nginx_server_name}"
  end

  task :restart do
    run "#{sudo} monit reload"
  end

end
