require "bundler/capistrano"
require "rvm/capistrano"

set :whenever_command, "bundle exec whenever"
require "whenever/capistrano"

set :application, "bic2013" #matches names used in smf_template.erb
set :repository,  "https://github.com/ucsd-iem/bic.git"
set :branch, :dev
set :domain, 'vishnu.ucsd.edu'
set :deploy_to, "/var/rails/#{application}" # I like this location
set :deploy_via, :remote_cache
set :user, "ubuntu"
set :keep_releases, 6
set :rvm_ruby_string, "1.9.3@#{application}"
set :server_name, "vishnu.ucsd.edu"
set :scm, :git


default_run_options[:pty] = true

role :app, domain
role :web, domain
role :db,  domain, :primary => true

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  desc "chown & chmod to www-data"
  task :chown do
    sudo "chown -R ubuntu:www-data #{deploy_to}"
    sudo "chmod -R 775 #{deploy_to}"
  end

  desc "Add config dir to shared folder"
  task :add_shared_config do
    run "mkdir #{deploy_to}/shared/config"
  end

  desc "Symlink configs"
  task :symlink_configs, :roles => :app do
    run "ln -nfs #{deploy_to}/shared/config/*.yml #{release_path}/config/"
  end
end

namespace :ckeditor do
  desc "Symlink the Rack::Cache files"
  task :symlink, :roles => [:app] do
    run "mkdir -p #{shared_path}/system/ckeditor_assets && ln -nfs #{shared_path}/system/ckeditor_assets #{release_path}/system/ckeditor_assets"
  end
end
after 'deploy:update_code', 'dragonfly:symlink'

namespace :dragonfly do
  desc "Symlink the Rack::Cache files"
  task :symlink, :roles => [:app] do
    run "mkdir -p #{shared_path}/tmp/dragonfly && ln -nfs #{shared_path}/tmp/dragonfly #{release_path}/tmp/dragonfly"
  end
end
after 'deploy:update_code', 'dragonfly:symlink'



after 'bundle:install', 'deploy:symlink_configs'
after 'deploy:setup', 'deploy:add_shared_config'
