require './boot'
require './model'

class Zero::Application < Sinatra::Application
  set :root,            Zero.root
  set :public_folder,   Zero.root + "/public"
  set :views,           Zero.root + "/views"
  set :environment,     Zero.env
  set :static_cache_control,    [:public, :max_age => 3000]

  # Welcome Page
  get '/' do
    slim :index
  end

  # Create action
  post '/create' do
    # Set content type to json
    content_type :json
    # Extract params
    long_url = params[:long_url].to_s
    return { code: -1 }.to_json if long_url.blank?
    # Add http scheme if none
    long_url = "http://" + long_url if URI(long_url).scheme.blank?
    # Find or create
    record      = Url.find_or_create_by_long_url_enhanced long_url
    { code: 0, short_id: record.short_id }.to_json
  end

  # Short url to long url
  get '/:short' do
    short = params[:short].to_s
    if short.match(/^[0-9a-zA-Z]+$/)
      record = Url.find_by_id Base62.decode(short)
      if record.present?
        slim :show, locals: { long_url: record.long_url }
      else
        pass
      end
    else
      pass
    end
  end

  # Not found page
  not_found do
  end

  # Error page
  error do
  end
end
