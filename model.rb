require 'active_record'
require 'logger'
require 'yaml'
require 'sqlite3'
require 'pg'

ActiveRecord::Base.logger = Logger.new(STDOUT)
ActiveSupport::LogSubscriber.colorize_logging = false
config = YAML::load(IO.read(Zero.root + '/config/database.yml'))
ActiveRecord::Base.establish_connection(config[Zero.env])

class Url < ActiveRecord::Base

  # Using hash to enhance query
  def self.find_or_create_by_long_url_enhanced(long_url)
    self.find_or_create_by({ 
      hash_md5: Digest::MD5.hexdigest(long_url), 
      hash_sha1: Digest::SHA1.hexdigest(long_url) 
    }) do |u|
      u.long_url = long_url
    end
  end

  # Generated short url identifier
  def short_id
    unless self.id.nil?
      Base62.encode self.id
    end
  end
end
