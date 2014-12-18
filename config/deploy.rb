# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'tokyo-kettle-jobs'
set :repo_url, 'git@github.com:TripolisSolutions/tokyo-kettle-jobs.git'
set :branch, 'trunk'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
# set :deploy_to, '/var/www/my_app'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
set :log_level, ENV['CAPISTRANO_LOG_LEVEL'].to_s.empty? ? :info : ENV['CAPISTRANO_LOG_LEVEL'].to_s.to_sym

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5


