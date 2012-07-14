require File.expand_path('../../../domain_model/db/podcasts_gateway', __FILE__)
require File.expand_path('../../../domain_model/entities/podcast', __FILE__)
class ListAllPodcasts
  def self.call
    new.call
  end
  def call
    Model::PodcastsGateway.all
  end
end
