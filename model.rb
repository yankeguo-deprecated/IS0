require 'active_record'
require 'logger'

# Init DB Connection

adapter = ENV['DB_ADAPTER'] || 'sqlite3'

if adapter == 'sqlite3'
  require 'sqlite3'
else
  require 'pg'
end

ActiveRecord::Base.logger = Logger.new(STDOUT)
ActiveSupport::LogSubscriber.colorize_logging = !Zero.production?

if adapter == 'sqlite3'
  ActiveRecord::Base.establish_connection({
    adapter: adapter,
    pool: 5,
    timeout: 5000,
    database: "#{Zero.root}/db/#{Zero.env}.sqlite3"
  })
else
end

# Model Definition

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
