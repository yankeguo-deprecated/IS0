require 'rubygems'
require 'bundler/setup'

require 'sinatra'
require 'base62'

module Zero
  class Application < Sinatra::Application
    set :public_folder, File.expand_path('../public', __FILE__)

    get '/' do
      'hello world'
    end

    post '/create' do
      'hello world'
    end

    get '/:short' do
      short = params[:short].to_s
      if short.match(/^[0-9a-zA-Z]+$/)
        id = Base62.decode(short)

        id.to_s
      else
        pass
      end
    end
  end
end
