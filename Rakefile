require './boot'
require './model'

task :default => :migrate

desc "Run migrations"
task :migrate do
    ActiveRecord::Migrator.migrate(Zero.root + '/db/migrate', ENV["VERSION"] ? ENV["VERSION"].to_i : nil)
end
