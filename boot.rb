require 'rubygems'
require 'bundler/setup'

require 'logger'
require 'sinatra'
require 'base62'

module Zero

  def self.root
    File.expand_path('../', __FILE__)
  end

  def self.env
    ENV['ZERO_ENV'] || 'development'
  end

end