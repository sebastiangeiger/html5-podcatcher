require 'domain_model/db/podcasts_gateway'
require 'domain_model/entities/podcast.rb'
class ListAllPodcasts
  def self.call
    new.call
  end
  def call
    Model::PodcastsGateway.all
  end
end
