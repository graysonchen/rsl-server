#!/usr/bin/env ruby
require "bundler/setup"
require "bundler/gem_tasks"
require 'sequel'
require "rsl-server"

namespace :db do
  task :migrate do
    # Sequel::Migrator.run(DB, "migrations")
    Sequel.extension :migration, :core_extensions
    Sequel::Migrator.apply DB, 'db/migrations'
  end
end
