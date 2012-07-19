require 'sinatra/base'
require 'json'
require File.expand_path('../../domain_model/interactors/list_all_podcasts',__FILE__)
require File.expand_path('../../domain_model/interactors/retrieve_feed_service',__FILE__)

class HtmlFivePodcatcher < Sinatra::Base
get '/api/v1/podcasts' do
  content_type :json
  ListAllPodcasts.call.to_json
end

post '/api/v1/podcasts' do
  content_type :json
  request.body.rewind  # in case someone already read it
  url = JSON.parse(request.body.read)["url"]
  RetrieveFeedService.call(url).to_json
end
end
