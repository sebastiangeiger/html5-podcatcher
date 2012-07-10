require 'sinatra'
require 'json'
require 'domain_model/interactors/list_all_podcasts.rb'

get '/api/v1/podcasts' do
  content_type :json
  ListAllPodcasts.call.to_json
end
