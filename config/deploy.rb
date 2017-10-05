require 'mina/rails'
require 'mina/git'
require 'mina/chruby'
require 'mina/unicorn'
require 'mina/puma'
# require 'mina/rbenv'  # for rbenv support. (https://rbenv.org)
# require 'mina/rvm'    # for rvm support. (https://rvm.io)

# Basic settings:
#   domain       - The hostname to SSH to.
#   deploy_to    - Path to deploy into.
#   repository   - Git repo to clone from. (needed by mina/git)
#   branch       - Branch name to deploy. (needed by mina/git)

set :application_name, 'majordom'
set :domain, '185.185.68.217'
set :deploy_to, '/home/deploy/apps/majordom'
set :repository, 'git@github.com:vursen/majordom.git'
set :branch, 'master'

set :chruby_path, '/usr/local/share/chruby/chruby.sh'
# Optional settings:
set :user, 'deploy'          # Username in the server to SSH to.
#   set :port, '30000'           # SSH port number.
set :forward_agent, true     # SSH forward_agent.
#
set :shared_paths, ['config/database.yml', 'tmp/pids', 'tmp/sockets']
set :shared_files, ['.env.production']

# shared dirs and files will be symlinked into the app-folder by the 'deploy:link_shared_paths' step.
# set :shared_dirs, fetch(:shared_dirs, []).push('somedir')
# set :shared_files, fetch(:shared_files, []).push('config/database.yml', 'config/secrets.yml')

# This task is the environment that is loaded for all remote run commands, such as
# `mina deploy` or `mina rake`.
task :environment do
  # If you're using rbenv, use this to load the rbenv environment.
  # Be sure to commit your .ruby-version or .rbenv-version to your repository.
  # invoke :'rbenv:load'
  invoke :chruby, '2.4.1'

  command %(export PATH="$HOME/.yarn/bin:$PATH")

  command %(export NVM_DIR="$HOME/.nvm")
  command %([ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh")  # This loads nvm
  command %([ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion")  # This loads nvm bash_completion

  command %(export NODE_ENV="production")
  # For those using RVM, use this to load an RVM version@gemset.
  # invoke :'rvm:use', 'ruby-1.9.3-p125@default'
end

# Put any custom commands you need to run at setup
# All paths in `shared_dirs` and `shared_paths` will be created on their own.
task :setup do
  # command %{rbenv install 2.3.0}
  shared_path  = fetch(:shared_path)
  command %(mkdir -p "#{shared_path}/tmp/sockets")
  command %(chmod g+rx,u+rwx "#{shared_path}/tmp/sockets")
  command %(mkdir -p "#{shared_path}/tmp/pids")
  command %(chmod g+rx,u+rwx "#{shared_path}/tmp/pids")
end

task :setup_front_environment do
  command %(curl -o- -L https://yarnpkg.com/install.sh | bash)

  command %(curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.4/install.sh | bash)
  command %(export NVM_DIR="$HOME/.nvm" [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion")

  command %(nvm install 8)
  command %(nvm use 8)
end

desc "Build assets"
task :build_assets do
  command %(yarn install)
  command %(node ./node_modules/gulp/bin/gulp build)
end


task :puma_start do
  invoke :'puma:start'
  command %(sleep 5)
end

task :puma_restart do
  invoke :'puma:restart'
  command %(sleep 5)
end


desc "Deploys the current version to the server."
task :deploy do
  # uncomment this line to make sure you pushed your local branch to the remote origin
  # invoke :'git:ensure_pushed'
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    command %(source /home/deploy/.bash_profile)
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :build_assets
    invoke :'deploy:cleanup'

    on :launch do
    end
  end
  # you can use `run :local` to run tasks on local machine before of after the deploy scripts
  # run(:local){ say 'done' }
end

# For help in making your deploy script, see the Mina documentation:
#
#  - https://github.com/mina-deploy/mina/tree/master/docs
