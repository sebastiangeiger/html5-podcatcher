require File.expand_path('../../../domain_model/entities/podcast',__FILE__)
require File.expand_path('../../../domain_model/db/podcasts_gateway.rb', __FILE__)
require File.expand_path('../../../external/podcasts_gateway.rb', __FILE__)
#TODO: Needs to be in model module
class RetrieveFeedService
  def self.call(url)
    new(url).call
  end

  def initialize(url)
    @url = url
  end

  def call
    podcast = Model::PodcastsGateway.find_by_url(@url)
    unless podcast
       podcast = External::PodcastsGateway.retrieve(@url)
    end
  end

end
