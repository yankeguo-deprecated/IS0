require 'active_record'
require 'sqlite3'
require 'pg'

ActiveRecord::Base.logger = Logger.new(Zero.root + "/log/model.log")
config = YAML::load(IO.read(Zero.root + '/config/database.yml'))
ActiveRecord::Base.establish_connection(config[Zero.env])

class Url < ActiveRecord::Base
end
