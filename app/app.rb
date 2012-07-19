require 'sinatra/base'
require 'haml'

class HtmlFivePodcatcher < Sinatra::Base
get '/' do
  haml :index
end
end

require 'app/api/api.rb'
