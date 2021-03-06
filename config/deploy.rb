# frozen_string_literal: true

# config valid for current version and patch releases of Capistrano
lock '~> 3.10.1'

set :application, 'motohelper'
set :repo_url, 'git@github.com:workshop-team/motohelper.git'
set :deploy_to, '/var/www/motohelper'

append(
  :linked_files
)

# Default value for linked_dirs is []
append(
  :linked_dirs,
  'log',
  'tmp/pids',
  'tmp/cache',
  'tmp/sockets',
  'public/uploads'
)

set :rollbar_token, ENV['ROLLBAR_ACCESS_TOKEN']
set :rollbar_env, (proc { fetch :stage })
set :rollbar_role, (proc { :app })

set :keep_releases, 5
set :whenever_identifier, -> { "#{fetch(:application)}_#{fetch(:stage)}" }
set :passenger_restart_with_touch, true
