require 'sinatra'
require 'json'
require 'domain_model/interactors/list_all_podcasts.rb'

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
