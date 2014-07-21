$:.unshift './lib'
require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rvm'

require 'mina/defaults'
require 'mina/extras'
require 'mina/god'
require 'mina/unicorn'
require 'mina/nginx'
require 'mina/log'

Dir['lib/mina/servers/*.rb'].each { |f| load f }

###########################################################################
# Common settings for all servers
###########################################################################

set :app,                'example'
set :repository,         'git@github.com'
set :default_server,     :production

###########################################################################
# Tasks
###########################################################################

set :server, ENV['to'] || default_server
invoke :"env:#{server}"

task :environment do
  # If you're using rbenv, use this to load the rbenv environment.
  # Be sure to commit your .rbenv-version to your repository.
  # invoke :'rbenv:load'

  # For those using RVM, use this to load an RVM version@gemset.
  queue echo_cmd %[/bin/bash --login]
end

desc "Deploys the current version to the server."

task :deploy => :environment do
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    to :launch do
      # relax, if your unicorn is not running. the unicorn.sh will change restarting to starting.
      invoke :'unicorn:restart'
    end
  end
end
