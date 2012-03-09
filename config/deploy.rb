set :user, 'deploy'
set :domain, 'capstone.colinrymer.com'
set :application, "capstone"
 
set :repository, "git@github.com:team-zwei/capstonerails.git" # Your clone URL
set :scm, "git"
set :branch, "master"
set :scm_verbose, true
set :deploy_via, :remote_cache
set :scm_passphrase, "#{Capistrano::CLI.ui.ask("Enter deploy user's ssh-key password: ")}" # The deploy user's ssh key passphrase
set :deploy_to, "/home/#{user}/#{domain}"
set :use_sudo, false
set :rvm_type, :user

# Add RVM's lib directory to the load path.
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
$LOAD_PATH.unshift File.join(File.dirname(__FILE__), 'deploy')
 
require "bundler/capistrano"
require "rvm/capistrano"
require "capistrano_database_yml"
 
default_run_options[:pty] = true
ssh_options[:forward_agent] = true
 
role :web, '66.228.60.212'
role :app, '66.228.60.212'
role :db, '66.228.60.212', :primary => true
 
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
 
after "deploy:migrations", "deploy:cleanup"
after "deploy:setup", "deploy:create_release_dir"

namespace :deploy do
  task :create_release_dir, :except => {:no_release => true} do
    run "mkdir -p #{fetch :releases_path}"
  end
end

namespace :deploy do
  task :dms do
    #drop_db
    create_db
    migrate
    seed_db
    restart
  end

  task :create_db, :roles => :app do
    run "cd #{current_path} && bundle exec rake RAILS_ENV=production db:create"
  end

  task :drop_db, :roles => :app do
    run "cd #{current_path} && bundle exec rake RAILS_ENV=production db:drop"
  end

  task :seed_db, :roles => :app do
    run "cd #{current_path} && bundle exec rake RAILS_ENV=production db:seed"
  end

end